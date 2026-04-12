import 'package:bloc/bloc.dart';
import 'package:todo/features/auth/domain/repositories/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._repo) : super(LoginInitial());

  final AuthRepo _repo;

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final result = await _repo.login(email, password);
    result.fold(
      (failure) => emit(LoginFailure(failure.errorMessage)),
      (_) => emit(LoginSuccess()),
    );
  }
}
