import 'package:fa_rag_ui/components/mini_select.dart';
import 'package:fa_rag_ui/core/domain/chat_interface.dart';
import 'package:fa_rag_ui/core/domain/chat_interface_observer.dart';
import 'package:flutter/material.dart';

class ChatInterfaceSelect extends StatelessWidget {
  const ChatInterfaceSelect({super.key, required this.onInterfaceSelected});

  final Function(ChatInterface?) onInterfaceSelected;

  @override
  Widget build(BuildContext context) {
    final chatInterfaces = ChatInterfaceObserverProvider.of(context);
    final Map<int, ChatInterface> services = chatInterfaces.all().asMap();
    return ListenableBuilder(
      builder: (context, _) {
        return MiniSelect(
          items: services.values
              .map((chatInterface) => chatInterface.name.value)
              .toList(),
          lable: 'Chat Interface',
          icon: Icon(Icons.model_training),
          onChanged: (index) {
            onInterfaceSelected(services[index]);
          },
        );
      },
      listenable: chatInterfaces,
    );
  }
}
