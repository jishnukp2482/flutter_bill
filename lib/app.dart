import 'package:flashy_flushbar/flashy_flushbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/presentation/routes/app_routes.dart';
import 'package:flutter_bill/presentation/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
      builder: FlashyFlushbarProvider.init(),
    );
  }
}
