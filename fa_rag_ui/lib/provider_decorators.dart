import 'package:fa_rag_core/core/core.dart';
import 'package:fa_rag_repository/repository.dart';
import 'package:fa_rag_ui/config/get_it.dart';
import 'package:fa_rag_ui/state/cubit/loader/loader_cubit.dart';
import 'package:fa_rag_ui/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/application_settings.dart';

class GlobalProviderDecorator extends StatelessWidget {
  const GlobalProviderDecorator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ApplicationSettingsProvider(
      applicationSettings: ApplicationSettings(),
      child: BlocDecorator(
        child: ChatInterfaceObserverProvider(
          chatInterfaceObserver: ChatInterfaceObserver({
            ChatInterfaceName.ollama: OllamaChatInterface(
              url: 'http://127.0.0.1:11434/api',
            ),
          }),
          child: ChatSnapshotPoolProvider(
            chatSnapshotPool: ChatSnapshotPool(),
            child: child,
          ),
        ),
      ),
    );
  }
}

class BlocDecorator extends StatelessWidget {
  const BlocDecorator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoaderCubit()),
        BlocProvider(
          create: (ctx) => PromptsCubit(
            ctx.read<LoaderCubit>(),
            getIt.get<CrudRepository>() as PromptsRepository,
          )..loadPrompts(),
        ),
      ],
      child: child,
    );
  }
}
