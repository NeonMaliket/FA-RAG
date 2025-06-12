// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fa_rag_ui/config/logger_config.dart';
import 'package:meta/meta.dart';

part 'loader_state.dart';

class LoaderCubit extends Cubit<LoaderState> {
  LoaderCubit() : super(LoaderInitial());

  void loading({String? message}) {
    logger.d('LoaderCubit: loading');
    if (state is LoaderLoading) {
      logger.w('LoaderCubit: already loading');
      return;
    }
    emit(LoaderLoading(message: message ?? 'Loading...'));
  }

  void loaded() {
    logger.d('LoaderCubit: loaded');
    if (state is LoaderLoaded) {
      logger.w('LoaderCubit: already loaded');
      return;
    }
    emit(LoaderLoaded());
  }
}
