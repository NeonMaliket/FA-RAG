import 'package:flutter/material.dart';

abstract class ChatModel extends ChangeNotifier {
  final String name;
  final bool isInstalled;

  ChatModel({required this.name, required this.isInstalled});

  Stream<String> sendMessage(String message);
}

class OllamaChatModel extends ChatModel {
  OllamaChatModel({required super.name, required super.isInstalled});

  @override
  Stream<String> sendMessage(String message) async* {
    yield "message yo";
  }
}
