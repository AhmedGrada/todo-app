import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/features/auth/data/models/user_model.dart';
import 'package:todo/features/auth/domain/entities/user_entity.dart';

class AuthRemoteDatasource {
  AuthRemoteDatasource(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  Stream<UserEntity?> get authStateStream {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) {
        return null;
      }
      return UserModel.fromFirebaseUser(firebaseUser);
    });
  }

  Future<UserEntity> login(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user == null) {
      throw Exception('User is not logged in');
    }
    return UserModel.fromFirebaseUser(credential.user!);
  }

  Future<UserEntity> register(String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user == null) {
      throw Exception('Registeration returned null user');
    }
    return UserModel.fromFirebaseUser(credential.user!);
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
