import 'package:equatable/equatable.dart';
import 'package:frenly/domain/entities/user_entity.dart';

abstract class UsersState extends Equatable {
  const UsersState();
}

class UsersInitial extends UsersState {
  @override
  List<Object?> get props => [];
}

class UsersLaoding extends UsersState {
  @override
  List<Object?> get props => [];
}

class UsersFailure extends UsersState {
  final String message;

  const UsersFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class UsersLoaded extends UsersState {
  final List<UserEntity> users;

  const UsersLoaded({required this.users});

  @override
  List<Object?> get props => [users];
}
