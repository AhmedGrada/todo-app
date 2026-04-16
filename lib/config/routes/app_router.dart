import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/config/routes/app_routes.dart';
import 'package:todo/core/services/get_it_service.dart';
import 'package:todo/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:todo/features/todo/presentation/screen/home_screen.dart';
import 'package:todo/features/auth/presentation/screens/login_screen.dart';
import 'package:todo/features/auth/presentation/screens/register_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter._();

  static final routeObserver = RouteObserver<ModalRoute<void>>();

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: kDebugMode,
    redirect: (context, state) {
      final isLoggedIn = getIt<AuthCubit>().isAuthenticated;
      if (!isLoggedIn) {
        return AppRoutes.login;
      }
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(path: AppRoutes.home, builder: (context, state) => HomeScreen()),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => RegisterScreen(),
      ),
    ],
  );
}
