import 'package:fa_rag_core/core/core.dart';
import 'package:flutter/material.dart';

class ChatSnapshotPool extends ChangeNotifier {
  final Map<String, ChatSnapshot> _snapshotPool = {};

  void add(ChatSnapshot snapshot) {
    _snapshotPool[snapshot.title] = snapshot;
    notifyListeners();
  }

  List<ChatSnapshot> list() {
    return _snapshotPool.values.toList();
  }

  ChatSnapshot? get(String title) {
    return _snapshotPool[title];
  }

  bool isEmpty() {
    return _snapshotPool.isEmpty;
  }

  void delete(String title) {
    _snapshotPool.remove(title);
    notifyListeners();
  }
}

class ChatSnapshotPoolProvider extends InheritedNotifier<ChatSnapshotPool> {
  const ChatSnapshotPoolProvider({
    super.key,
    required super.child,
    required this.chatSnapshotPool,
  }) : super(notifier: chatSnapshotPool);
  final ChatSnapshotPool chatSnapshotPool;

  static ChatSnapshotPool of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<ChatSnapshotPoolProvider>();
    if (provider == null) {
      throw Exception('ChatSnapshotPoolProvider not regestered');
    }

    return provider.chatSnapshotPool;
  }
}
