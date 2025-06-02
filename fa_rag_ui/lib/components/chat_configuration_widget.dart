import 'package:fa_rag_ui/core/domain/chat_interface_observer.dart';
import 'package:fa_rag_ui/core/domain/chat_model.dart';
import 'package:flutter/material.dart';

import 'package:fa_rag_ui/core/domain/chat_interface.dart';
import 'package:fa_rag_ui/components/ai/chat_interface_select.dart';
import 'package:fa_rag_ui/components/ai/chat_model_select.dart';

class ChatConfigurationWidget extends StatefulWidget {
  const ChatConfigurationWidget({
    super.key,
    required this.onInterfaceSelected,
    required this.onModelSelected,
  });

  final Function(ChatInterface?) onInterfaceSelected;
  final Function(ChatModel?) onModelSelected;

  @override
  State<ChatConfigurationWidget> createState() =>
      _ChatConfigurationWidgetState();
}

class _ChatConfigurationWidgetState extends State<ChatConfigurationWidget> {
  ChatInterface? chatInterface;
  bool initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!initialized) {
      final serviceProvider = ChatInterfaceObserverProvider.of(context);
      final services = serviceProvider.all();
      chatInterface = services.isNotEmpty ? services.first : null;
      setState(() {});
      initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        ChatInterfaceSelect(
          onInterfaceSelected: (selectedInterface) {
            chatInterface = selectedInterface;
            widget.onInterfaceSelected(selectedInterface);
            setState(() {});
          },
        ),
        if (chatInterface != null)
          ChatModelSelect(
            onModelChaged: (model) {
              widget.onModelSelected(model);
            },
            chatInterface: chatInterface!,
          ),
      ],
    );
  }
}
