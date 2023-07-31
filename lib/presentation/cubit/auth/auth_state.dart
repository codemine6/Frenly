import 'package:equatable/equatable.dart';
import 'package:frenly/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthCreated extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  final UserEntity user;

  const Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}
