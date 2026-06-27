import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grade_tracker/providers/grade_provider.dart';
import 'package:grade_tracker/theme/app_theme.dart';
import 'package:grade_tracker/screens/main_navigation_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GradeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch GradeProvider to rebuild when theme changes
    final provider = context.watch<GradeProvider>();

    return MaterialApp(
      title: 'Student Grade Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: provider.themeMode,
      home: const MainNavigationScreen(),
    );
  }
}
