part of 'prompts_cubit.dart';

@immutable
sealed class PromptsState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class PromptsInitial extends PromptsState {}

final class PromptsSaving extends PromptsState {
  final Prompt prompt;

  PromptsSaving(this.prompt);

  @override
  List<Object> get props => [prompt];
}

final class PromptsUpdating extends PromptsState {
  final Prompt prompt;

  PromptsUpdating(this.prompt);

  @override
  List<Object> get props => [prompt];
}

final class PromptsUpdated extends PromptsState {}

final class PromptsSaved extends PromptsState {}

final class PromptsLoading extends PromptsState {}

final class PromptsLoaded extends PromptsState {
  final List<Prompt> prompts;

  PromptsLoaded(this.prompts);

  @override
  List<Object> get props => [prompts];
}

final class RemovePrompt extends PromptsState {
  final String title;

  RemovePrompt(this.title);

  @override
  List<Object> get props => [title];
}

final class PromptRemoved extends PromptsState {
  final String title;

  PromptRemoved(this.title);

  @override
  List<Object> get props => [title];
}

final class PromptsError extends PromptsState {
  final String message;

  PromptsError(this.message);

  @override
  List<Object> get props => [message];
}
