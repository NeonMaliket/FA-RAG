import 'package:flutter/services.dart';

Future<String> markdown() async {
  await Future.delayed(Duration(seconds: 3));
  return await rootBundle.loadString('assets/README.md');
}
