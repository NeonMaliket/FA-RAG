import 'package:fa_rag_core/core/core.dart';
import 'package:fa_rag_ui/components/mini_select.dart';
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
        final chatInterfaceNames = services.values
            .map((chatInterface) => chatInterface.name.value)
            .toList();
        return MiniSelect(
          items: chatInterfaceNames,
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
