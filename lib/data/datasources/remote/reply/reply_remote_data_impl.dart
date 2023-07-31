import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:frenly/data/datasources/remote/reply/reply_remote_data.dart';
import 'package:frenly/data/models/reply_model.dart';
import 'package:frenly/domain/entities/reply_entity.dart';
import 'package:uuid/uuid.dart';

class ReplyRemoteDataImpl implements ReplyRemoteData {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  ReplyRemoteDataImpl({
    required this.auth,
    required this.firestore,
    required this.storage,
  });

  @override
  Future<void> createReply(ReplyEntity reply) async {
    final commentId = const Uuid().v1();
    final image = reply.imageFile != null
        ? await () async {
            final storageRef = storage.ref('replies').child(commentId);
            await storageRef.putFile(reply.imageFile!);
            return storageRef.getDownloadURL();
          }()
        : null;
    final repliesCollection = firestore
        .collection('posts')
        .doc(reply.postId)
        .collection('comments')
        .doc(reply.commentId)
        .collection('replies');
    final uid = auth.currentUser?.uid;
    final data = ReplyModel(
      authorId: uid,
      commentId: reply.commentId,
      postId: reply.postId,
      createdAt: Timestamp.now(),
      image: image,
      likeCount: 0,
      message: reply.message,
    ).toMap();
    await repliesCollection.doc(commentId).set(data);

    final postDocument = firestore.collection('posts').doc(reply.postId);
    await postDocument.update({'commentCount': FieldValue.increment(1)});
    final commentDocument = firestore
        .collection('posts')
        .doc(reply.postId)
        .collection('comments')
        .doc(reply.commentId);
    await commentDocument.update({'replyCount': FieldValue.increment(1)});
  }

  @override
  Future<void> deleteReply(ReplyEntity reply) async {
    final replyDocument = firestore
        .collection('posts')
        .doc(reply.postId)
        .collection('comments')
        .doc(reply.commentId)
        .collection('replies')
        .doc(reply.id);

    final likesCollection = replyDocument.collection('likes');
    final likesSnapshot = await likesCollection.get();
    for (var like in likesSnapshot.docs) {
      likesCollection.doc(like.id).delete();
    }

    try {
      await storage.ref('replies').child(reply.id!).delete();
    } catch (_) {}
    await replyDocument.delete();
    final postDocument = firestore.collection('posts').doc(reply.postId);
    await postDocument.update({'commentCount': FieldValue.increment(-1)});
    final commentDocument =
        postDocument.collection('comments').doc(reply.commentId);
    await commentDocument.update({'replyCount': FieldValue.increment(-1)});
  }

  @override
  Future<void> editReply(ReplyEntity reply) async {
    final image = reply.imageFile != null
        ? await () async {
            final storageRef = storage.ref('replies').child(reply.id!);
            await storageRef.putFile(reply.imageFile!);
            return storageRef.getDownloadURL();
          }()
        : null;
    final replyDocument = firestore
        .collection('posts')
        .doc(reply.postId)
        .collection('comments')
        .doc(reply.commentId)
        .collection('replies')
        .doc(reply.id);
    await replyDocument.update({
      'image': image ?? reply.imageUrl,
      'message': reply.message,
    });
  }

  @override
  Stream<List<ReplyEntity>> getReplies(ReplyEntity reply) {
    final usersCollection = firestore.collection('users');
    final repliesCollection = firestore
        .collection('posts')
        .doc(reply.postId)
        .collection('comments')
        .doc(reply.commentId)
        .collection('replies');

    return repliesCollection
        .orderBy('createdAt')
        .snapshots()
        .asyncMap((event) => Future.wait(event.docs.map((replySnapshot) async {
              final authorId = replySnapshot.data()['authorId'];
              final userSnapshot = await usersCollection.doc(authorId).get();
              final liked = (await repliesCollection
                      .doc(replySnapshot.id)
                      .collection('likes')
                      .doc(authorId)
                      .get())
                  .exists;
              return ReplyModel.fromDocument(
                replySnapshot,
                userSnapshot,
                liked,
              );
            })));
  }

  @override
  Future<void> likeReply(ReplyEntity reply) async {
    final uid = auth.currentUser?.uid;
    final replyDocument = firestore
        .collection('posts')
        .doc(reply.postId)
        .collection('comments')
        .doc(reply.commentId)
        .collection('replies')
        .doc(reply.id);
    final likeDocument = replyDocument.collection('likes').doc(uid);
    final snapshot = await likeDocument.get();
    if (snapshot.exists) {
      likeDocument.delete();
      replyDocument.update({'likeCount': FieldValue.increment(-1)});
    } else {
      likeDocument.set({'likedAt': Timestamp.now()});
      replyDocument.update({'likeCount': FieldValue.increment(1)});
    }
  }
}
