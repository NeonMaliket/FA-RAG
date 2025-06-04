import 'package:fa_rag_core/core/core.dart';
import 'package:flutter/material.dart';

import 'domain/application_settings.dart';

class GlobalProviderDecorator extends StatelessWidget {
  const GlobalProviderDecorator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ApplicationSettingsProvider(
      applicationSettings: ApplicationSettings(),
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
    );
  }
}
