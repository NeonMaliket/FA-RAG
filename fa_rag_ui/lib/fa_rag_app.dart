import 'package:fa_rag_ui/domain/domain.dart';
import 'package:fa_rag_ui/feature/main_window/main_window.dart';
import 'package:fa_rag_ui/theme/rag_theme.dart';
import 'package:flutter/material.dart';

class FaRagApp extends StatelessWidget {
  const FaRagApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = ApplicationSettingsProvider.of(context);
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        return MaterialApp(
          title: 'FA-RAG',
          theme: ragAppLightTheme,
          debugShowCheckedModeBanner: false,
          darkTheme: ragAppDarkTheme,
          themeMode: settings.currentThemeMode,
          home: MainWindow(),
        );
      },
    );
  }
}
