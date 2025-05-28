import 'package:fa_rag_ui/feature/main_window/main_window.dart';
import 'package:fa_rag_ui/theme/rag_theme.dart';
import 'package:flutter/material.dart';

class FaRagApp extends StatelessWidget {
  const FaRagApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FA-RAG',
      theme: ragAppLightTheme,
      debugShowCheckedModeBanner: false,
      darkTheme: ragAppDarkTheme,
      themeMode: ThemeMode.dark,
      home: MainWindow(),
    );
  }
}
