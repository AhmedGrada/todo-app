import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/auth/domain/repositories/auth_repo.dart';

part 'resetpassword_state.dart';

class ResetpasswordCubit extends Cubit<ResetpasswordState> {
  ResetpasswordCubit(this._repo) : super(ResetpasswordInitial());

  final AuthRepo _repo;

  Future<void> resetPassword(String email) async {
    emit(ResetpasswordLoading());
    final result = await _repo.resetPassword(email);
    result.fold(
      (failure) => emit(ResetpasswordFailure(failure.errorMessage)),
      (_) => emit(ResetpasswordSuccess()),
    );
  }
}
