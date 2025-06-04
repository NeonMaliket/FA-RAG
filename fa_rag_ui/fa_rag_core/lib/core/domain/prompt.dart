enum PromptType { system, user, agent }

class Prompt {
  String message;
  PromptType type;
  DateTime cteatedAt;
  Prompt({required this.message, required this.type, required this.cteatedAt});
}
