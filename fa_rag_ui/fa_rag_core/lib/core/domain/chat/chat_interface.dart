// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fa_rag_core/core/config/dio_config.dart';
import 'package:fa_rag_core/core/config/logger_config.dart';
import 'package:fa_rag_core/core/core.dart';

enum ChatInterfaceName {
  ollama
  // openAI,
  // huggingface,
  // gemini,
  // mistral,
  // claude,
  // azureOpenAI,
  // perplexity,
  // groq,
  // togetherAI
  ;

  String get value => {ollama: 'Ollama'}[this] ?? 'Local';
}

class Message {
  final String chank;
  final bool done;

  Message({required this.chank, required this.done});

  factory Message.fromChunk(final String chunk) {
    // {"model":"tinyllama:latest","created_at":"2025-06-04T14:56:12.798559Z","message":{"role":"assistant","content":"."},"done":false}
    final decoded = jsonDecode(chunk);
    final String message = decoded["message"]?["content"];
    final bool done = decoded["done"];
    return Message(chank: message, done: done);
  }
}

abstract class ChatInterface {
  final String url;
  final ChatInterfaceName name;
  final StreamController<Uint8List> messages = StreamController.broadcast();

  ChatInterface({required this.url, required this.name});

  Stream<int> installModel(ChatModel model);
  Future<Set<ChatModel>> availableModels();

  void sendMessage(String message, ChatModel model);

  Message modelChankParse(String chank);

  Stream<Message> messagesStream() {
    return messages.stream
        .map((uint8List) => String.fromCharCodes(uint8List))
        .map(modelChankParse);
  }
}

class OllamaChatInterface extends ChatInterface {
  OllamaChatInterface({
    required super.url,
    super.name = ChatInterfaceName.ollama,
  });

  @override
  Stream<int> installModel(ChatModel model) async* {
    for (int i = 0; i <= 100; i++) {
      Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }

  @override
  Future<Set<ChatModel>> availableModels() async {
    final localUrl = "$url/tags";
    final List<String> localModels = [];
    try {
      final response = await dio.get(localUrl);
      final data = response.data;
      localModels.addAll(
        List.from(
          data['models'],
        ).map((model) => model["model"] as String).toList(),
      );
    } catch (e) {
      logger.w('ERROR: $e');
    }

    return localModels
        .map((model) => OllamaChatModel(isInstalled: false, name: model))
        .toSet();
  }

  @override
  void sendMessage(String message, ChatModel model) async {
    final localUrl = "$url/chat";

    try {
      final body = {
        "model": model.name,
        "messages": [
          {"role": "user", "content": message},
        ],
        "stream": true,
      };

      final response = await dio.post(
        localUrl,
        data: body,
        options: Options(
          responseType: ResponseType.stream,
          headers: {
            'Accept': 'text/event-stream',
            'Content-Type': 'application/json',
          },
        ),
      );

      logger.i('Sent message: $body');

      final stream = response.data.stream;
      await messages.addStream(stream);
    } catch (e) {
      logger.w('ERROR: $e');
    }
  }

  @override
  Message modelChankParse(String chank) {
    return Message.fromChunk(chank);
  }
}
