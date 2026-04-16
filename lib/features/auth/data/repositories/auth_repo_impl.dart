import 'package:todo/core/remote/remote_call.dart';
import 'package:todo/core/utils/typedef.dart';
import 'package:todo/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:todo/features/auth/domain/entities/user_entity.dart';
import 'package:todo/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this._remoteDatasource);

  final AuthRemoteDatasource _remoteDatasource;

  @override
  Stream<UserEntity?> get authStateStream => _remoteDatasource.authStateStream;

  @override
  FutureOf<UserEntity> login(String email, String password) async {
    return executeRemoteCall(() => _remoteDatasource.login(email, password));
  }

  @override
  FutureOf<UserEntity> register(String email, String password) async {
    return executeRemoteCall(() => _remoteDatasource.register(email, password));
  }

  @override
  FutureVoid resetPassword(String email) async {
    return executeRemoteCall(() => _remoteDatasource.resetPassword(email));
  }

  @override
  FutureVoid logout() async {
    return executeRemoteCall(() => _remoteDatasource.logout());
  }
}
