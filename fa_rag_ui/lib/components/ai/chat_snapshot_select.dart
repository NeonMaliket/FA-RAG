import 'package:fa_rag_ui/components/mini_select.dart';
import 'package:fa_rag_ui/core/core.dart';
import 'package:flutter/material.dart';

class ChatSnapshotSelect extends StatelessWidget {
  const ChatSnapshotSelect({super.key, required this.onSnapshotSelected});

  final Function(ChatSnapshot?) onSnapshotSelected;

  @override
  Widget build(BuildContext context) {
    final chatSnapshotPool = ChatSnapshotPoolProvider.of(context);

    final Map<int, ChatSnapshot> pool = chatSnapshotPool.list().asMap();
    return ListenableBuilder(
      builder: (context, _) {
        return MiniSelect(
          items: pool.isEmpty
              ? []
              : pool.values.map((snap) => snap.title).toList(),
          lable: 'Chat Interface',
          icon: Icon(Icons.model_training),
          onChanged: (index) {
            if (pool.isNotEmpty) {
              onSnapshotSelected(pool[index]);
            }
          },
        );
      },
      listenable: chatSnapshotPool,
    );
  }
}
