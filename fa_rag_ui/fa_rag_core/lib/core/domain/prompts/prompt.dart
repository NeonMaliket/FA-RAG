// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

enum PromptType { system, user, agent }

class Prompt extends Equatable {
  final String title;
  final String message;
  final PromptType type;
  final DateTime createdAt;

  Prompt({
    required this.title,
    required this.message,
    required this.type,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  List<Object> get props => [title, message, type, createdAt];

  String get createdAtTimeFormatted =>
      '${createdAt.hour}:${createdAt.minute.toString().padLeft(2, '0')}';

  String get createdAtDateFormatted =>
      '${createdAt.day.toString().padLeft(2, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.year}';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'message': message,
      'type': type.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Prompt.fromMap(Map<String, dynamic> map) {
    return Prompt(
      title: map['title'] as String,
      message: map['message'] as String,
      type: PromptType.values.firstWhere(
        (e) => e.name == map['type'] as String,
        orElse: () => throw Exception('Invalid prompt type'),
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Prompt.fromJson(String source) =>
      Prompt.fromMap(json.decode(source) as Map<String, dynamic>);
}
