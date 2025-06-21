import 'package:flutter/material.dart';
import 'screens/intro_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const BullsEyeApp());
}

class BullsEyeApp extends StatelessWidget {
  const BullsEyeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BullsEye',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const IntroScreen(),
    );
  }
}
