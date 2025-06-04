import 'package:fa_rag_ui/components/components.dart';
import 'package:fa_rag_ui/config/logger_config.dart';
import 'package:fa_rag_ui/core/domain/chat_interface.dart';
import 'package:fa_rag_ui/core/domain/chat_model.dart';
import 'package:flutter/material.dart';

class ChatModelSelect extends StatefulWidget {
  const ChatModelSelect({
    super.key,
    required this.onModelChaged,
    required this.chatInterface,
  });

  final ChatInterface chatInterface;
  final Function(ChatModel?) onModelChaged;

  @override
  State<ChatModelSelect> createState() => _ChatModelSelectState();
}

class _ChatModelSelectState extends State<ChatModelSelect> {
  late final Future<Set<ChatModel>> chatModels;
  bool _modelSet = false;

  @override
  void initState() {
    super.initState();
    chatModels = widget.chatInterface.availableModels();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: chatModels,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          final Set<ChatModel> chatModels = asyncSnapshot.data!;
          if (chatModels.isNotEmpty) {
            final Map<int, ChatModel> chatModelMap = chatModels
                .toList()
                .asMap();
            if (!_modelSet) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                widget.onModelChaged(chatModelMap[0]);
              });
              _modelSet = true;
            }
            logger.i("future");
            return MiniSelect(
              items: chatModels.map((model) => model.name).toList(),
              lable: 'Model',
              icon: Icon(Icons.rocket),
              onChanged: (index) {
                widget.onModelChaged(chatModelMap[index]);
              },
            );
          }
        }
        return SizedBox.shrink();
      },
    );
  }
}
