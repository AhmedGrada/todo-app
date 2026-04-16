import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:todo/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:todo/features/auth/domain/repositories/auth_repo.dart';
import 'package:todo/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:todo/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:todo/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:todo/features/todo/data/datasources/todo_remote_datasoruce.dart';
import 'package:todo/features/todo/data/repositories/todo_repo_impl.dart';
import 'package:todo/features/todo/domain/repositories/todo_repo.dart';
import 'package:todo/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:todo/features/auth/presentation/cubit/reset_password/resetpassword_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  await getIt.allReady();

  // Auth
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt()));

  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(getIt<FirebaseAuth>()),
  );

  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));
  getIt.registerFactory<ResetpasswordCubit>(() => ResetpasswordCubit(getIt()));

  // Todo
  getIt.registerLazySingleton<TodoRepo>(() => TodoRepoImpl(getIt()));
  getIt.registerLazySingleton<TodoRemoteDatasource>(
    () => TodoRemoteDatasource(getIt<FirebaseFirestore>()),
  );
  getIt.registerFactory<TodoCubit>(() => TodoCubit(getIt()));

  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
}
