import 'package:fa_rag_core/core/core.dart';

class PromptsStore {
  final Map<PromptType, List<Prompt>> _store = {};

  void addPrompt(Prompt prompt) {
    _store.putIfAbsent(prompt.type, () => []).add(prompt);
  }

  void updatePrompt(String oldTitle, Prompt prompt) {
    final oldType = _store.keys.firstWhere(
      (type) => _store[type]!.any((p) => p.title == oldTitle),
      orElse: () => throw Exception('Prompt with title $oldTitle not found.'),
    );
    if (_store.containsKey(oldType)) {
      _store[prompt.type] = _store[oldType]!
          .map((p) => p.title == oldTitle ? prompt : p)
          .toList();
    } else {
      throw Exception('Prompt type ${prompt.type} not found in store.');
    }
  }

  List<Prompt> getPrompts([PromptType? type]) {
    return type != null
        ? _store[type] ?? []
        : _store.values.expand((prompts) => prompts).toList();
  }

  List<Prompt> getByTitle(String title, [PromptType? type]) {
    if (type != null) {
      return _store[type]?.where((prompt) => prompt.title == title).toList() ??
          [];
    }
    return _store.values
        .expand((prompts) => prompts.where((prompt) => prompt.title == title))
        .toList();
  }

  void removePrompt(String title, [PromptType? type]) {
    if (type != null) {
      _store[type]?.removeWhere((prompt) => prompt.title == title);
    } else {
      _store.forEach((_, prompts) {
        prompts.removeWhere((prompt) => prompt.title == title);
      });
    }
  }
}
