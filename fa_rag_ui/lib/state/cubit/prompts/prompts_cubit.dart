// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fa_rag_core/core/core.dart';
import 'package:meta/meta.dart';

part 'prompts_state.dart';

class PromptsCubit extends Cubit<PromptsState> {
  PromptsCubit() : super(PromptsInitial());

  final PromptsStore _promptsStore = PromptsStore();

  void savePrompt(Prompt prompt) {
    emit(PromptsSaving(prompt));
    _promptsStore.addPrompt(prompt);
    emit(PromptsSaved());
  }

  void updatePrompt(String oldTitle, Prompt prompt) {
    emit(PromptsUpdating(prompt));
    _promptsStore.updatePrompt(oldTitle, prompt);
    emit(PromptsUpdated());
  }

  void loadPrompts([PromptType? type]) async {
    emit(PromptsLoading());
    await Future.delayed(const Duration(seconds: 1));
    final prompts = _promptsStore.getPrompts(type);
    emit(PromptsLoaded(prompts));
  }

  void removePrompt(String title, [PromptType? type]) {
    emit(RemovePrompt(title));
    _promptsStore.removePrompt(title, type);
    emit(PromptRemoved(title));
  }
}
