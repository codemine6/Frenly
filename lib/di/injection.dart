import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:frenly/di/cubit.dart';
import 'package:frenly/di/datasource.dart';
import 'package:frenly/di/repository.dart';
import 'package:frenly/di/usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  registerCubit(getIt);
  registerUseCase(getIt);
  registerDataSource(getIt);
  registerRepository(getIt);

  // Firebase
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => FirebaseStorage.instance);
}
