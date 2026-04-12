import 'package:flutter/material.dart';
import 'package:todo/config/routes/app_router.dart';

class AppConfig extends StatefulWidget {
  const AppConfig({super.key});

  @override
  State<AppConfig> createState() => _AppConfigState();
}

class _AppConfigState extends State<AppConfig> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      routerConfig: AppRouter.router,

      builder: (context, child) {
        return child!;
      },
    );
  }
}
