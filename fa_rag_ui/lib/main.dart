import 'dart:io';

import 'package:fa_rag_repository/config.dart';
import 'package:fa_rag_ui/config/get_it.dart';
import 'package:fa_rag_ui/fa_rag_app.dart';
import 'package:fa_rag_ui/provider_decorators.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  setupGetIt();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(800, 600));
    setWindowMaxSize(Size.infinite);
  }

  runApp(GlobalProviderDecorator(child: const FaRagApp()));
}
