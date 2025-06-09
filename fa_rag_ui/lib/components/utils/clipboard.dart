import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TinyClipboard extends StatelessWidget {
  const TinyClipboard({super.key, required this.message, required this.child});

  final String message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      preferBelow: false,
      message: 'Copy to clipboard',
      child: InkWell(
        onTap: () => Clipboard.setData(ClipboardData(text: message)),
        child: child,
      ),
    );
  }
}
