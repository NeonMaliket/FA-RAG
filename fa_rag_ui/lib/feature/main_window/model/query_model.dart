import 'package:fa_rag_ui/core/core.dart';
import 'package:flutter/material.dart';

class QueryInterfaceModel extends ChangeNotifier {
  final List<Prompt> history = List.empty();
  //selection ai model
  //selection vectorization alhorithm

  void sendUserQuery(String message) {
    history.add(
      Prompt(
        message: message,
        type: PromptType.user,
        cteatedAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void sendAgentQuery(String message) {
    history.add(
      Prompt(
        message: message,
        type: PromptType.agent,
        cteatedAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}

class QueryProvider extends InheritedNotifier<QueryInterfaceModel> {
  const QueryProvider({
    super.key,
    required this.queryModel,
    required super.child,
  }) : super(notifier: queryModel);

  final QueryInterfaceModel queryModel;

  static QueryInterfaceModel of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<QueryProvider>();

    if (provider == null) {
      throw Exception('Query Proveder not registered');
    }

    return provider.notifier!;
  }
}
