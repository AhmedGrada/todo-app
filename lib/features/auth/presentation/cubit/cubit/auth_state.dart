part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoggedIn extends AuthState {
  AuthLoggedIn(this.user);

  final UserEntity user;
}

final class AuthLoggedOut extends AuthState {}
