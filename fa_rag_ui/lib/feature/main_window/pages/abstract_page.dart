import 'package:fa_rag_ui/theme/rag_theme.dart';
import 'package:flutter/widgets.dart';

class AbstractPage extends StatelessWidget {
  const AbstractPage({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 50,
      children: [
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Text(title, style: context.theme().textTheme.headlineLarge),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: child,
        ),
      ],
    );
  }
}
