// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fa_rag_core/core/core.dart';
import 'package:fa_rag_repository/repository.dart';
import 'package:fa_rag_ui/config/logger_config.dart';
import 'package:fa_rag_ui/state/cubit/loader/loader_cubit.dart';
import 'package:meta/meta.dart';

part 'prompts_state.dart';

class PromptsCubit extends Cubit<PromptsState> {
  PromptsCubit(this._loaderCubit, this._promptsRepository)
    : super(PromptsInitial());

  final LoaderCubit _loaderCubit;
  final CrudRepository<Prompt> _promptsRepository;

  void savePrompt(final Prompt prompt) async {
    _loaderCubit.loading();
    await _promptsRepository.create(prompt);
    _loaderCubit.loaded();
    loadPrompts();
  }

  void updatePrompt(final String oldTitle, final Prompt prompt) async {
    _loaderCubit.loading();
    await _promptsRepository.update(oldTitle, prompt);
    _loaderCubit.loaded();
    loadPrompts();
  }

  void loadPrompts() async {
    emit(PromptsLoading());
    _loaderCubit.loading();
    try {
      logger.d('Loading prompts from repository');
      final prompts = await _promptsRepository.getAll(
        compare: (a, b) => a.compareTo(b),
      );
      _loaderCubit.loaded();
      emit(PromptsLoaded(prompts));
    } catch (e) {
      logger.e('Error loading prompts: $e');
      _loaderCubit.loaded();
      emit(PromptsLoaded([]));
      emit(PromptsError(e.toString()));
    }
  }

  void removePrompt(final String title) async {
    _loaderCubit.loading();
    await _promptsRepository.delete(title);
    _loaderCubit.loaded();
    loadPrompts();
  }

  Future<bool> promptExists(final String title) async {
    _loaderCubit.loading();
    final response = await _promptsRepository.existsById(title);
    _loaderCubit.loaded();
    return response;
  }

  Future<Prompt?> getPromptByTitle(final String title) async {
    _loaderCubit.loading();
    final response = await _promptsRepository.getById(title);
    _loaderCubit.loaded();
    return response;
  }
}
