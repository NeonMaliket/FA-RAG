// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fa_rag_core/core/core.dart';
import 'package:fa_rag_repository/repository.dart';
import 'package:meta/meta.dart';

part 'prompts_state.dart';

class PromptsCubit extends Cubit<PromptsState> {
  PromptsCubit(this._promptsRepository) : super(PromptsInitial());

  final CrudRepository<Prompt> _promptsRepository;

  void savePrompt(Prompt prompt) async {
    emit(PromptsSaving(prompt));
    await _promptsRepository.create(prompt);
    emit(PromptsSaved());
  }

  void updatePrompt(String oldTitle, Prompt prompt) async {
    emit(PromptsUpdating(prompt));
    await _promptsRepository.update(oldTitle, prompt);
    emit(PromptsUpdated());
  }

  void loadPrompts([PromptType? type]) async {
    emit(PromptsLoading());
    await Future.delayed(const Duration(seconds: 1));
    final prompts = await _promptsRepository.getAll();
    emit(PromptsLoaded(prompts));
  }

  void removePrompt(String title) async {
    emit(RemovePrompt(title));
    await _promptsRepository.delete(title);
    emit(PromptRemoved(title));
  }

  Future<bool> promptExists(String title) async {
    return await _promptsRepository.existsById(title);
  }

  Future<Prompt?> getPromptByTitle(String title) async {
    return await _promptsRepository.getById(title);
  }
}
