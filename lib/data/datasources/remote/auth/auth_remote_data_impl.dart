import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frenly/data/datasources/remote/auth/auth_remote_data.dart';
import 'package:frenly/data/models/user_model.dart';
import 'package:frenly/domain/entities/user_entity.dart';

class AuthRemoteDataImpl implements AuthRemoteData {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDataImpl({required this.auth, required this.firestore});

  @override
  Future<UserEntity> getAuthStatus() async {
    final usersCollection = firestore.collection('users');
    final uid = auth.currentUser?.uid;
    final snapshot = await usersCollection.doc(uid).get();
    return UserModel.fromDocument(snapshot);
  }

  @override
  Future<UserEntity> signInUser(UserEntity user) async {
    final usersCollection = firestore.collection('users');
    final credential = await auth.signInWithEmailAndPassword(
      email: user.email!,
      password: user.password!,
    );
    final snapshot = await usersCollection.doc(credential.user?.uid).get();
    return UserModel.fromDocument(snapshot);
  }

  @override
  Future<void> signOutUser() async {
    return await auth.signOut();
  }

  @override
  Future<void> signUpUser(UserEntity user) async {
    final usersCollection = firestore.collection('users');
    final credential = await auth.createUserWithEmailAndPassword(
      email: user.email!,
      password: user.password!,
    );
    final data = UserModel(
      bio: '',
      email: user.email,
      joinAt: Timestamp.now(),
      name: user.name,
      profileImage: 'https://bit.ly/3Rp4G1V',
    ).toMap();
    return await usersCollection.doc(credential.user?.uid).set(data);
  }
}
