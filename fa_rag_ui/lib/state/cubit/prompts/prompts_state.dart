part of 'prompts_cubit.dart';

@immutable
sealed class PromptsState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class PromptsInitial extends PromptsState {}

final class PromptsLoading extends PromptsState {}

final class PromptsLoaded extends PromptsState {
  final List<Prompt> prompts;

  PromptsLoaded(this.prompts);

  @override
  List<Object> get props => [prompts];
}

final class PromptsError extends PromptsState {
  final String message;

  PromptsError(this.message);

  @override
  List<Object> get props => [message];
}
