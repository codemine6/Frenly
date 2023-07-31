import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:frenly/data/datasources/remote/post/post_remote_data.dart';
import 'package:frenly/data/models/post_model.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/domain/entities/user_entity.dart';

class PostRemoteDataImpl implements PostRemoteData {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  PostRemoteDataImpl({
    required this.auth,
    required this.firestore,
    required this.storage,
  });

  @override
  Future<void> createPost(PostEntity post) async {
    final urls = post.images?.map((image) async {
      try {
        final name = image.path.split('/').last;
        final storageRef = storage.ref('posts').child(name);
        await storageRef.putFile(image);
        return storageRef.getDownloadURL();
      } catch (_) {}
    }).toList();

    final images = await Future.wait(urls!);
    final uid = auth.currentUser?.uid;
    final postsCollection = firestore.collection('posts');
    final data = PostModel(
      authorId: uid,
      archived: false,
      commentCount: 0,
      createdAt: Timestamp.now(),
      description: post.description,
      images: images,
      likeCount: 0,
    ).toMap();
    await postsCollection.add(data);
  }

  @override
  Future<List<PostEntity>> getPosts() async {
    final postsCollection = firestore.collection('posts');
    final usersCollection = firestore.collection('users');
    final snapshot =
        await postsCollection.orderBy('createdAt', descending: true).get();

    final posts = snapshot.docs.map((postSnapshot) async {
      final authorId = postSnapshot.data()['authorId'];
      final userSnapshot = await usersCollection.doc(authorId).get();
      final liked = (await postsCollection
              .doc(postSnapshot.id)
              .collection('likes')
              .doc(authorId)
              .get())
          .exists;
      return PostModel.fromDocument(postSnapshot, userSnapshot, liked);
    });
    return Future.wait(posts);
  }

  @override
  Future<List<PostEntity>> getUserPosts(UserEntity user) async {
    final postsCollection = firestore.collection('posts');
    final snapshot =
        await postsCollection.where('authorId', isEqualTo: user.id).get();
    return snapshot.docs
        .map((postSnapshot) => PostModel.fromDocument(postSnapshot))
        .toList();
  }

  @override
  Future<void> likePost(PostEntity post) async {
    final uid = auth.currentUser?.uid;
    final postDocument = firestore.collection('posts').doc(post.id);
    final likeDocument = postDocument.collection('likes').doc(uid);
    final snapshot = await likeDocument.get();
    if (snapshot.exists) {
      likeDocument.delete();
      postDocument.update({'likeCount': FieldValue.increment(-1)});
    } else {
      likeDocument.set({'likedAt': Timestamp.now()});
      postDocument.update({'likeCount': FieldValue.increment(1)});
    }
  }
}
