import 'package:fa_rag_ui/theme/rag_theme.dart';
import 'package:flutter/material.dart';

openModalBottomSheet(
  BuildContext context, {
  required Widget child,
  bool isScrollControlled = true,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    isScrollControlled: isScrollControlled,
    backgroundColor: Colors.transparent,

    builder: (context) => FractionallySizedBox(heightFactor: 0.7, child: child),
  );
}

openTinyModalBottomSheet(
  BuildContext context, {
  required Widget child,
  bool isScrollControlled = true,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    isScrollControlled: isScrollControlled,
    backgroundColor: context.theme().colorScheme.surface,

    builder: (context) => FractionallySizedBox(heightFactor: 0.9, child: child),
  );
}
