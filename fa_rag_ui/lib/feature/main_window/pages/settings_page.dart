import 'package:fa_rag_ui/feature/main_window/pages/abstract_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AbstractPage(
      title: 'Settings',
      child: Center(child: Column(children: [])),
    );
  }
}
