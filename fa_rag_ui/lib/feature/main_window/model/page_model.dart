import 'package:flutter/widgets.dart';

class PageModel extends ChangeNotifier {
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  void pageTo(index) {
    _currentIndex = index;
    notifyListeners();
  }
}
