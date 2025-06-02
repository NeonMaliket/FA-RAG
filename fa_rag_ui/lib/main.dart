import 'dart:io';

import 'package:fa_rag_ui/fa_rag_app.dart';
import 'package:fa_rag_ui/global_provider_decorator.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(800, 600));
    setWindowMaxSize(Size.infinite);
  }

  runApp(GlobalProviderDecorator(child: const FaRagApp()));
}
