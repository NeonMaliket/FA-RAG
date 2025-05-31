import 'package:flutter/material.dart';

extension WindowBasedMetrics on BuildContext {
  double vw(double vw) {
    return MediaQuery.of(this).size.width * (vw / 100);
  }

  double vh(double vh) {
    return MediaQuery.of(this).size.height * (vh / 100);
  }

  double get width {
    return MediaQuery.of(this).size.width;
  }

  double get height {
    return MediaQuery.of(this).size.height;
  }
}
