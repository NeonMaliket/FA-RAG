import 'package:fa_rag_ui/components/components.dart';
import 'package:fa_rag_ui/core/domain/chat_interface.dart';
import 'package:flutter/material.dart';

import 'package:fa_rag_ui/core/domain/chat_model.dart';

class ChatModelSelect extends StatelessWidget {
  const ChatModelSelect({
    super.key,
    required this.onModelChaged,
    required this.chatInterface,
  });

  final ChatInterface chatInterface;
  final Function(ChatModel?) onModelChaged;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: chatInterface.availableModels(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          final Set<ChatModel> chatModels = asyncSnapshot.data!;
          if (chatModels.isNotEmpty) {
            final Map<int, ChatModel> chatModelMap = chatModels
                .toList()
                .asMap();
            return MiniSelect(
              items: chatModels.map((model) => model.name).toList(),
              lable: 'Model',
              icon: Icon(Icons.rocket),
              onChanged: (index) {
                onModelChaged(chatModelMap[index]);
              },
            );
          }
        }

        return SizedBox.shrink();
      },
    );
  }
}
