import 'package:todo/core/utils/typedef.dart';
import 'package:todo/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Stream<UserEntity?> get authStateStream;

  FutureOf<UserEntity> login(String email, String password);

  FutureOf<UserEntity> register(String email, String password);

  FutureVoid logout();
}
