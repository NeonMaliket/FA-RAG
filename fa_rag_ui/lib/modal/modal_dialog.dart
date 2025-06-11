import 'package:flutter/material.dart';

class ModalDialog {
  final String title;
  final String content;
  final Function? onConfirm;
  final Function? onCancel;
  final Widget? customAction;

  ModalDialog({
    required this.title,
    required this.content,
    this.onConfirm,
    this.onCancel,
    this.customAction,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          Row(
            spacing: 10,
            children: [
              if (customAction != null) Expanded(flex: 1, child: customAction!),
              Expanded(flex: 2, child: SizedBox.shrink()),
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () {
                    if (onCancel != null) {
                      onCancel!();
                    }
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Cancel'),
                ),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    if (onConfirm != null) {
                      onConfirm!();
                    }
                    Navigator.of(context).pop(true);
                  },
                  child: Text('OK'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
