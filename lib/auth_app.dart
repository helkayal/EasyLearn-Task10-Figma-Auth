import 'package:flutter/material.dart';
import 'package:task10_figma_auth/core/theme/app_theme.dart';

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: Scaffold(body: Center(child: Text('Auth App!'))),
    );
  }
}
