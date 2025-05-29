import 'package:fa_rag_ui/domain/application_settings.dart';
import 'package:fa_rag_ui/fa_rag_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    ApplicationSettingsProvider(
      notifier: ApplicationSettings(),
      child: const FaRagApp(),
    ),
  );
}
