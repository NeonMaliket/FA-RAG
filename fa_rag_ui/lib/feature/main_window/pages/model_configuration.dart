import 'package:fa_rag_ui/components/chat_configuration_widget.dart';
import 'package:fa_rag_ui/core/core.dart';
import 'package:fa_rag_ui/core/domain/chat_interface.dart';
import 'package:fa_rag_ui/core/domain/chat_model.dart';
import 'package:fa_rag_ui/feature/main_window/pages/abstract_page.dart';
import 'package:flutter/material.dart';

class ModelConfiguration extends StatefulWidget {
  const ModelConfiguration({super.key});

  @override
  State<ModelConfiguration> createState() => _ModelConfigurationState();
}

class _ModelConfigurationState extends State<ModelConfiguration> {
  late final GlobalKey _formKey;
  late final TextEditingController _titleController;
  ChatInterface? _chatInterface;
  ChatModel? _chatModel;

  late final ChatSnapshotPool _chatSnapshotPool;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController(text: "");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _chatSnapshotPool = ChatSnapshotPoolProvider.of(context);
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AbstractPage(
      title: 'Model Configuration',
      actions: [
        ChatConfigurationWidget(
          onInterfaceSelected: (ChatInterface? selected) {
            _chatInterface = selected;
            setState(() {});
          },
          onModelSelected: (ChatModel? selected) {
            if (mounted) {
              _chatModel = selected;
              setState(() {});
            }
          },
        ),
      ],
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 10,
          children: [
            TextField(
              decoration: InputDecoration(label: Text('Configuration Title')),
              keyboardType: TextInputType.text,
              controller: _titleController,
            ),

            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_chatInterface != null && _chatModel != null) {
                  final chatSnapshot = ChatSnapshot(
                    title: _titleController.text,
                    chatInterface: _chatInterface!,
                    chatModel: _chatModel!,
                  );
                  _chatSnapshotPool.add(chatSnapshot);
                }
              },
              child: Text('Create Snapshot'),
            ),
          ],
        ),
      ),
    );
  }
}
