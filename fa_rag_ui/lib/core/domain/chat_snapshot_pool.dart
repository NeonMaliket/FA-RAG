import 'package:fa_rag_ui/core/core.dart';
import 'package:flutter/material.dart';

class ChatSnapshotPool extends ChangeNotifier {
  final Map<String, ChatSnapshot> snapshotPool = {};

  void add(ChatSnapshot snapshot) {
    snapshotPool[snapshot.title] = snapshot;
    notifyListeners();
  }

  List<ChatSnapshot> list() {
    return snapshotPool.values.toList();
  }

  ChatSnapshot? get(String title) {
    return snapshotPool[title];
  }

  void delete(String title) {
    snapshotPool.remove(title);
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
