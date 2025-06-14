// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fa_rag_core/core/core.dart';
import 'package:flutter/material.dart';

class ChatSnapshot extends ChangeNotifier {
  final String title;

  final ChatInterface chatInterface;
  final ChatModel chatModel;

  ChatSnapshot({
    required this.title,
    required this.chatInterface,
    required this.chatModel,
  });
}
