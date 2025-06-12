import 'package:fa_rag_core/core/domain/prompts/prompt.dart';
import 'package:fa_rag_ui/components/components.dart';
import 'package:fa_rag_ui/config/logger_config.dart';
import 'package:fa_rag_ui/feature/main_window/pages/abstract_page.dart';
import 'package:fa_rag_ui/modal/modal.dart';
import 'package:fa_rag_ui/state/state.dart';
import 'package:fa_rag_ui/theme/rag_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class PromptsPage extends StatelessWidget {
  const PromptsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PromptsCubit>().loadPrompts();
    return AbstractPage(
      title: 'Prompts',
      actions: [
        ElevatedButton(
          onPressed: () {
            openModalBottomSheet(context, child: _NewPrompt());
          },
          child: Text('Add Prompt'),
        ),
      ],
      child: SizedBox(
        child: BlocBuilder<PromptsCubit, PromptsState>(
          builder: (context, state) {
            if (state is PromptsLoaded) {
              final prompts = state.prompts;
              if (prompts.isEmpty) {
                return const Center(child: Text('No prompts available.'));
              }
              return ListView.builder(
                itemCount: prompts.length,
                itemBuilder: (context, index) {
                  final prompt = prompts[index];
                  return GestureDetector(
                    child: _PromptCard(prompt: prompt),
                    onTap: () {
                      openTinyModalBottomSheet(
                        context,
                        child: _PromptPreview(prompt: prompt),
                      );
                    },
                  );
                },
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _NewPrompt extends StatefulWidget {
  const _NewPrompt({this.fromPrompt});

  final Prompt? fromPrompt;

  @override
  State<_NewPrompt> createState() => _NewPromptState();
}

class _NewPromptState extends State<_NewPrompt> {
  final List<String> _promptTypes = ['User', 'System', 'Agent'];
  final List<PromptType> _promptTypesEnum = [
    PromptType.user,
    PromptType.system,
    PromptType.agent,
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _textTitleController;
  late final TextEditingController _textMessageController;
  late PromptType _promptType;

  @override
  void initState() {
    super.initState();
    _textTitleController = TextEditingController(
      text: widget.fromPrompt?.title ?? '',
    );
    _textMessageController = TextEditingController(
      text: widget.fromPrompt?.message ?? '',
    );
    _promptType = widget.fromPrompt?.type ?? PromptType.user;
  }

  @override
  void dispose() {
    _textTitleController.dispose();
    _textMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 25,
          children: [
            Text(
              'Create a prompt',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  flex: 7,
                  child: TextFormField(
                    validator: _validate,
                    controller: _textTitleController,
                    decoration: InputDecoration(labelText: 'Prompt Title'),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: MiniSelect(
                    lable: "Prompt Type",
                    items: _promptTypes,
                    onChanged: onPromtTypeChanged,
                    initialIndex: 0,
                    icon: Icon(Icons.arrow_drop_down),
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: _textMessageController,
              validator: _validate,
              decoration: InputDecoration(labelText: 'Prompt Message'),
              maxLines: 5,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () async {
                  final title = _textTitleController.text.trim();
                  final existing = await _findByTitle(title);

                  if (existing != null) {
                    ModalDialog(
                      title: 'Prompt already exists',
                      content:
                          'A prompt with the title "$title" already exists. Do you want to update it?',
                      onConfirm: () {
                        _saveOrUpdatePrompt();
                      },
                      customAction: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          openTinyModalBottomSheet(
                            context,
                            child: _PromptPreview(prompt: existing),
                          );
                        },
                        child: Text('Show'),
                      ),
                    ).show(context);
                  } else {
                    _saveOrUpdatePrompt();
                  }
                },
                child: const Text('Save Prompt'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onPromtTypeChanged(index) {
    setState(() {
      _promptType = _promptTypesEnum[index ?? 0];
    });
  }

  Future<Prompt?> _findByTitle(String title) async {
    final Prompt? prompt = await context.read<PromptsCubit>().getPromptByTitle(
      title,
    );
    logger.i("Prompt with title '$title' exists: ${prompt != null}");
    return prompt;
  }

  void _saveOrUpdatePrompt() {
    if (_formKey.currentState?.validate() ?? false) {
      final title = _textTitleController.text;
      final message = _textMessageController.text;

      final prompt = Prompt(title: title, message: message, type: _promptType);
      if (widget.fromPrompt != null) {
        final oldTitle = widget.fromPrompt!.title;
        context.read<PromptsCubit>().updatePrompt(oldTitle, prompt);
      } else {
        context.read<PromptsCubit>().savePrompt(prompt);
      }
      context.read<PromptsCubit>().loadPrompts();
      Navigator.pop(context);
    }
  }

  String? _validate(String? value) {
    logger.i("Validating value: $value");
    if (value == null || value.isEmpty) {
      return 'Textfield cannot be empty';
    }
    return null;
  }
}

class _PromptCard extends StatelessWidget {
  const _PromptCard({required this.prompt});

  final Prompt prompt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  prompt.type == PromptType.system
                      ? Icons.settings
                      : prompt.type == PromptType.user
                      ? Icons.person
                      : Icons.abc,
                  size: 40,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      prompt.title,
                      style: context.theme().textTheme.headlineSmall,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "${prompt.type.name} prompt",
                            style: context
                                .theme()
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: context.theme().colorScheme.secondary,
                                ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${prompt.createdAtDateFormatted}  |  ${prompt.createdAtTimeFormatted}',
                            style: context
                                .theme()
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: context.theme().colorScheme.secondary,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      prompt.message,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      openModalBottomSheet(
                        context,
                        child: _NewPrompt(fromPrompt: prompt),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: context.theme().colorScheme.error,
                    ),
                    onPressed: () {
                      context.read<PromptsCubit>().removePrompt(prompt.title);
                      context.read<PromptsCubit>().loadPrompts();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PromptPreview extends StatelessWidget {
  const _PromptPreview({required this.prompt});
  final Prompt prompt;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox.shrink(),
              TinyClipboard(message: prompt.title, child: Text(prompt.title)),
              Text(
                "${prompt.type.name} prompt",
                style: context.theme().textTheme.labelLarge?.copyWith(
                  color: context.theme().colorScheme.secondary,
                ),
              ),
            ],
          ),
          pinned: true,
          expandedHeight: 50,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverToBoxAdapter(
            child: TinyClipboard(
              message: prompt.message,
              child: GptMarkdown(
                prompt.message,
                style: context.theme().textTheme.bodyLarge?.copyWith(
                  color: context.theme().colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
