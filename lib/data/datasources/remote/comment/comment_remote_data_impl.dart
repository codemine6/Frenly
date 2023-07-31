import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:frenly/data/datasources/remote/comment/comment_remote_data.dart';
import 'package:frenly/data/models/comment_model.dart';
import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:uuid/uuid.dart';

class CommentRemoteDataImpl implements CommentRemoteData {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  CommentRemoteDataImpl({
    required this.auth,
    required this.firestore,
    required this.storage,
  });

  @override
  Future<void> createComment(CommentEntity comment) async {
    final uid = auth.currentUser?.uid;
    final commentId = const Uuid().v1();
    final image = comment.imageFile != null
        ? await () async {
            final storageRef = storage.ref('comments').child(commentId);
            await storageRef.putFile(comment.imageFile!);
            return storageRef.getDownloadURL();
          }()
        : null;
    final commentsCollection = firestore
        .collection('posts')
        .doc(comment.postId)
        .collection('comments');
    final data = CommentModel(
      authorId: uid,
      postId: comment.postId,
      createdAt: Timestamp.now(),
      image: image,
      likeCount: 0,
      message: comment.message,
      replyCount: 0,
    ).toMap();
    await commentsCollection.doc(commentId).set(data);

    final postDocument = firestore.collection('posts').doc(comment.postId);
    await postDocument.update({'commentCount': FieldValue.increment(1)});
  }

  @override
  Future<void> deleteComment(CommentEntity comment) async {
    final postDocument = firestore.collection('posts').doc(comment.postId);
    final commentDocument = firestore
        .collection('posts')
        .doc(comment.postId)
        .collection('comments')
        .doc(comment.id);

    final likeCollection = commentDocument.collection('likes');
    final likesSnapshot = await likeCollection.get();
    for (var like in likesSnapshot.docs) {
      likeCollection.doc(like.id).delete();
    }

    final replyCollection = commentDocument.collection('replies');
    final repliesSnapshot = await replyCollection.get();
    for (var reply in repliesSnapshot.docs) {
      final likeCollectionChild =
          replyCollection.doc(reply.id).collection('likes');
      final likesSnapshotChild = await likeCollectionChild.get();
      for (var like in likesSnapshotChild.docs) {
        likeCollectionChild.doc(like.id).delete();
      }

      try {
        await storage.ref('replies').child(reply.id).delete();
      } catch (_) {}
      replyCollection.doc(reply.id).delete();
      await postDocument.update({'commentCount': FieldValue.increment(-1)});
    }

    try {
      await storage.ref('comments').child(comment.id!).delete();
    } catch (_) {}
    await commentDocument.delete();
    await postDocument.update({'commentCount': FieldValue.increment(-1)});
  }

  @override
  Future<void> editComment(CommentEntity comment) async {
    final image = comment.imageFile != null
        ? await () async {
            final storageRef = storage.ref('comments').child(comment.id!);
            await storageRef.putFile(comment.imageFile!);
            return storageRef.getDownloadURL();
          }()
        : null;
    final commentsDocument = firestore
        .collection('posts')
        .doc(comment.postId)
        .collection('comments')
        .doc(comment.id);
    await commentsDocument.update({
      'image': image ?? comment.imageUrl,
      'message': comment.message,
    });
  }

  @override
  Future<List<CommentEntity>> getComments(CommentEntity comment) async {
    final commentsCollection = firestore
        .collection('posts')
        .doc(comment.postId)
        .collection('comments');

    final snapshot = await commentsCollection.orderBy('createdAt').get();
    final comments = snapshot.docs.map((commentSnapshot) async {
      final authorId = commentSnapshot.data()['authorId'];
      final userSnapshot =
          await firestore.collection('users').doc(authorId).get();
      final liked = (await commentsCollection
              .doc(commentSnapshot.id)
              .collection('likes')
              .doc(authorId)
              .get())
          .exists;

      return CommentModel.fromDocument(commentSnapshot, userSnapshot, liked);
    });
    return Future.wait(comments);
  }

  @override
  Future<void> likeComment(CommentEntity comment) async {
    final uid = auth.currentUser?.uid;
    final commentDocument = firestore
        .collection('posts')
        .doc(comment.postId)
        .collection('comments')
        .doc(comment.id);
    final likeDocument = commentDocument.collection('likes').doc(uid);
    final snapshot = await likeDocument.get();
    if (snapshot.exists) {
      likeDocument.delete();
      commentDocument.update({'likeCount': FieldValue.increment(-1)});
    } else {
      likeDocument.set({'likedAt': Timestamp.now()});
      commentDocument.update({'likeCount': FieldValue.increment(1)});
    }
  }
}
