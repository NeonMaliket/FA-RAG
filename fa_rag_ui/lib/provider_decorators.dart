import 'package:fa_rag_core/core/core.dart';
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
      providers: [BlocProvider(create: (_) => PromptsCubit())],
      child: child,
    );
  }
}
