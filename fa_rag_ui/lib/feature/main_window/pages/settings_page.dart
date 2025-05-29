import 'package:fa_rag_ui/feature/main_window/pages/abstract_page.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AbstractPage(
      title: 'Settings',
      child: Center(child: Column(children: [ThemeSwitcher()])),
    );
  }
}

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  ThemeMode themeMode = ThemeMode.system;
  final themeMap = {0: ThemeMode.dark, 1: ThemeMode.system, 2: ThemeMode.light};

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.color_lens),
      title: Text('Theme Mode'),
      trailing: ToggleButtons(
        isSelected: [_isDarkTheme, _isSystemTheme, _isLishtTheme],
        onPressed: (index) {
          themeMode = themeMap[index] ?? themeMode;
          setState(() {});
        },
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        children: [
          Text('Dark'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text('System'),
          ),
          Text('Light'),
        ],
      ),
    );
  }

  bool get _isDarkTheme => themeMode == ThemeMode.dark;
  bool get _isSystemTheme => themeMode == ThemeMode.system;
  bool get _isLishtTheme => themeMode == ThemeMode.light;
}
