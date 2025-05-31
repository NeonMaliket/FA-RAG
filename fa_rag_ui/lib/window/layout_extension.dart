import 'package:flutter/widgets.dart';

const transformWidth = 900;

extension LayoutExtension on BoxConstraints {
  get isTablet => maxWidth < 800;

  get isPC => maxWidth > 1200;
}

extension ContextLayoutExtension on BuildContext {
  get isMobile => _query.size.width < 820;

  get isTablet => _query.size.width > 850 && _query.size.width <= 1100;

  get isPC => _query.size.width > 1100;

  get isPortrait => _query.orientation == Orientation.portrait;

  get isLandscape => _query.orientation == Orientation.landscape;

  MediaQueryData get _query => MediaQuery.of(this);
}
