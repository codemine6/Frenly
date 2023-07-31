import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:frenly/data/datasources/remote/user/user_remote_data.dart';
import 'package:frenly/data/models/user_model.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/utils/notification_services.dart';

class UserRemoteDataImpl implements UserRemoteData {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  UserRemoteDataImpl({
    required this.auth,
    required this.firestore,
    required this.storage,
  });

  @override
  Future<void> followUser(UserEntity user) async {
    final uid = auth.currentUser?.uid;
    final usersCollection = firestore.collection('users');
    final followersCollection =
        firestore.collection('users').doc(user.id).collection('followers');
    final followingCollection =
        firestore.collection('users').doc(uid).collection('following');

    final snapshot = await followersCollection.doc(uid).get();
    if (snapshot.exists) {
      followersCollection.doc(uid).delete();
      followingCollection.doc(user.id).delete();
      usersCollection
          .doc(user.id)
          .update({'followersCount': FieldValue.increment(-1)});
      usersCollection
          .doc(uid)
          .update({'followingCount': FieldValue.increment(-1)});
    } else {
      followersCollection.doc(uid).set({'followedAt': Timestamp.now()});
      followingCollection.doc(user.id).set({'followedAt': Timestamp.now()});
      usersCollection
          .doc(user.id)
          .update({'followersCount': FieldValue.increment(1)});
      usersCollection
          .doc(uid)
          .update({'followingCount': FieldValue.increment(1)});

      final token = (await usersCollection.doc(user.id).get()).data()!['token'];
      NotificationServices().sendFollowNotification(token);
    }
  }

  @override
  Future<List<UserEntity>> getFollowersUser(UserEntity user) async {
    final uid = auth.currentUser?.uid;
    final usersCollection = firestore.collection('users');
    final snapshot =
        await usersCollection.doc(user.id).collection('followers').get();
    final users = snapshot.docs.map((document) async {
      final snapshot = await usersCollection.doc(document.id).get();
      final followed = (await usersCollection
              .doc(uid)
              .collection('following')
              .doc(document.id)
              .get())
          .exists;
      return UserModel.fromDocument(snapshot, followed);
    });
    return Future.wait(users);
  }

  @override
  Future<List<UserEntity>> getFollowingUser(UserEntity user) async {
    final usersCollection = firestore.collection('users');
    final snapshot =
        await usersCollection.doc(user.id).collection('following').get();
    final users = snapshot.docs.map((document) async {
      final snapshot = await usersCollection.doc(document.id).get();
      return UserModel.fromDocument(snapshot);
    });
    return Future.wait(users);
  }

  @override
  Future<UserEntity> getUserDetail(UserEntity user) async {
    final uid = auth.currentUser?.uid;
    final usersCollection = firestore.collection('users');
    final snapshot = await usersCollection.doc(user.id).get();
    final followed = (await usersCollection
            .doc(user.id)
            .collection('followers')
            .doc(uid)
            .get())
        .exists;
    return UserModel.fromDocument(snapshot, followed);
  }

  @override
  Future<void> setProfile(UserEntity user) async {
    final uid = auth.currentUser?.uid;
    final usersCollection = firestore.collection('users');

    auth.currentUser?.updateDisplayName(user.name);

    return await usersCollection.doc(uid).update({
      'bio': user.bio,
      'name': user.name,
    });
  }

  @override
  Stream<TaskSnapshot> setProfileImage(UserEntity user) {
    final uid = auth.currentUser?.uid;
    final usersCollection = firestore.collection('users');
    final storageRef = storage.ref('users').child(uid!);
    final snapshot = storageRef.putData(user.profileImageFile!);
    storageRef.getDownloadURL().then((value) {
      usersCollection.doc(uid).update({'profileImage': value});
    });
    return snapshot.snapshotEvents;
  }

  @override
  Future<void> setUsername(UserEntity user) async {
    final uid = auth.currentUser?.uid;
    final usersCollection = firestore.collection('users');
    return await usersCollection.doc(uid).update({'username': user.username});
  }
}
