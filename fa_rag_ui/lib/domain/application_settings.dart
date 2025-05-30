import 'package:flutter/material.dart';

class ApplicationSettings extends ChangeNotifier {
  ThemeMode _currentThemeMode = ThemeMode.system;

  ThemeMode get currentThemeMode => _currentThemeMode;

  bool get isSystemThemeMode => _currentThemeMode == ThemeMode.system;
  bool get isDarkThemeMode => _currentThemeMode == ThemeMode.dark;
  bool get isLightThemeMode => _currentThemeMode == ThemeMode.light;

  void turnTo(themeMode) {
    if (_currentThemeMode != themeMode) {
      _currentThemeMode = themeMode;
      notifyListeners();
    }
  }
}

class ApplicationSettingsProvider
    extends InheritedNotifier<ApplicationSettings> {
  const ApplicationSettingsProvider({
    super.key,
    required this.applicationSettings,
    required super.child,
  }) : super(notifier: applicationSettings);

  final ApplicationSettings applicationSettings;

  static ApplicationSettings of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<ApplicationSettingsProvider>();

    if (provider == null) {
      throw Exception('SettingsProvider not found in widget tree');
    }
    return provider.notifier!;
  }
}
