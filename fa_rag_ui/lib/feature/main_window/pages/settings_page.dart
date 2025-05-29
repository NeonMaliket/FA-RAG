import 'package:fa_rag_ui/domain/domain.dart';
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

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = ApplicationSettingsProvider.of(context);
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        return ListTile(
          leading: Icon(Icons.color_lens),
          title: Text('Theme Mode'),
          trailing: ToggleButtons(
            isSelected: [
              settings.isDarkThemeMode,
              settings.isSystemThemeMode,
              settings.isLightThemeMode,
            ],
            onPressed: (index) {
              settings.turnTo(_themeMap[index] ?? ThemeMode.system);
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
      },
    );
  }

  Map<int, ThemeMode> get _themeMap => {
    0: ThemeMode.dark,
    1: ThemeMode.system,
    2: ThemeMode.light,
  };
}
