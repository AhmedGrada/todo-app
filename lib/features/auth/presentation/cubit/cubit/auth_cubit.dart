import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:todo/features/auth/domain/entities/user_entity.dart';
import 'package:todo/features/auth/domain/repositories/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _repo;
  late final StreamSubscription<UserEntity?> _authStateSubscription;
  AuthCubit(this._repo) : super(AuthInitial()) {
    _authStateSubscription = _repo.authStateStream.listen((user) {
      if (user == null) {
        emit(AuthLoggedOut());
      } else {
        emit(AuthLoggedIn(user));
      }
    });
  }
  bool get isAuthenticated => state is AuthLoggedIn;

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }
}
