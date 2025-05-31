import 'package:fa_rag_ui/theme/rag_theme.dart';
import 'package:flutter/widgets.dart';

class AbstractPage extends StatelessWidget {
  const AbstractPage({
    super.key,
    required this.title,
    required this.child,
    this.actions = const [],
  });

  final String title;
  final Widget child;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 50,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(50.0).copyWith(bottom: 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: context.theme().textTheme.headlineLarge,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: actions,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: child,
          ),
        ),
      ],
    );
  }
}
