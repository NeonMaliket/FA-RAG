import 'package:fa_rag_ui/core/domain/chat_interface.dart';
import 'package:flutter/material.dart';

class ChatInterfaceObserver extends ChangeNotifier {
  final Map<ChatInterfaceName, ChatInterface> _chatInterfaces;

  ChatInterfaceObserver(this._chatInterfaces);

  void add(ChatInterface interface) {
    _chatInterfaces[interface.name] = interface;
    notifyListeners();
  }

  List<ChatInterface> all() {
    return _chatInterfaces.values.toList();
  }
}

class ChatInterfaceObserverProvider
    extends InheritedNotifier<ChatInterfaceObserver> {
  const ChatInterfaceObserverProvider({
    super.key,
    required super.child,
    required this.chatInterfaceObserver,
  }) : super(notifier: chatInterfaceObserver);

  final ChatInterfaceObserver chatInterfaceObserver;

  static ChatInterfaceObserver of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<ChatInterfaceObserverProvider>();
    if (provider == null) {
      throw Exception('ChatInterfaceObserverProvider not registered.');
    }

    return provider.notifier!;
  }
}
