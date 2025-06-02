import 'package:fa_rag_ui/config/dio_config.dart';
import 'package:fa_rag_ui/config/logger_config.dart';
import 'package:fa_rag_ui/core/domain/chat_model.dart';

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

abstract class ChatInterface {
  final String url;
  final ChatInterfaceName name;
  bool isInstalled = false;

  ChatInterface({required this.url, required this.name});

  Stream<int> installModel(ChatModel model);
  Future<Set<ChatModel>> availableModels();
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
}
