import 'package:flutter/widgets.dart';

class PageModel extends ChangeNotifier {
  int _currentIndex = 1;

  get currentIndex => _currentIndex;

  void pageTo(index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class MainPageProvider extends InheritedNotifier<PageModel> {
  const MainPageProvider({
    super.key,
    required this.pageModel,
    required super.child,
  }) : super(notifier: pageModel);

  final PageModel pageModel;

  static PageModel of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<MainPageProvider>();

    if (provider == null) {
      throw Exception("MainPageProvider has not been regestered!");
    }

    return provider.pageModel;
  }
}
