import 'package:equatable/equatable.dart';

enum PromptType { system, user, agent }

class Prompt extends Equatable {
  final String title;
  final String message;
  final PromptType type;
  final DateTime cteatedAt;

  Prompt({
    required this.title,
    required this.message,
    required this.type,
    DateTime? createdAt,
  }) : cteatedAt = createdAt ?? DateTime.now();

  @override
  List<Object> get props => [title, message, type, cteatedAt];
}
