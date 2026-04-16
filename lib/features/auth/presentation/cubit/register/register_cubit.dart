import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/auth/domain/repositories/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepository) : super(RegisterInitial());
  final AuthRepo authRepository;

  Future<void> register(String email, String password) async {
    emit(RegisterLoading());
    final result = await authRepository.register(email, password);
    result.fold(
      (failure) => emit(RegisterFailure(failure.errorMessage)),
      (user) => emit(RegisterSuccess()),
    );
  }
}
