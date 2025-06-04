import 'package:fa_rag_core/core/core.dart';
import 'package:fa_rag_ui/components/ai/chat_snapshot_select.dart';
import 'package:fa_rag_ui/config/logger_config.dart';
import 'package:fa_rag_ui/feature/main_window/pages/abstract_page.dart';
import 'package:fa_rag_ui/theme/rag_theme.dart';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class QueryPage extends StatefulWidget {
  const QueryPage({super.key});

  @override
  State<QueryPage> createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  ChatSnapshot? snapshot;
  final textController = TextEditingController(text: "");
  final modelResponse = StringBuffer("");

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final chatSnapshotPool = ChatSnapshotPoolProvider.of(context);
    snapshot = chatSnapshotPool.list().first;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbstractPage(
      title: 'Query Interface',
      actions: [
        ChatSnapshotSelect(
          onSnapshotSelected: (ChatSnapshot? snap) {
            logger.i("From query: ${snap?.title}");
            if (snap != null) {
              snapshot = snap;
              setState(() {});
            }
          },
        ),
      ],
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar.medium(
            collapsedHeight: 100,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 100,
            expandedHeight: 175.0,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              title: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      flex: 9,
                      child: Form(
                        child: TextField(
                          controller: textController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: 'User Message',
                            alignLabelWithHint: true,
                            suffixIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsetsGeometry.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      size: 21,
                                      color: context
                                          .theme()
                                          .colorScheme
                                          .secondary,
                                    ),
                                    onPressed: () {
                                      logger.i("Snapshot: ${snapshot?.title}}");
                                      if (snapshot != null) {
                                        snapshot!.chatInterface.sendMessage(
                                          textController.text,
                                          snapshot!.chatModel,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverAnimatedList(
            initialItemCount: 1,
            itemBuilder: (context, index, animation) {
              if (snapshot == null) {
                return SizedBox.shrink();
              }
              return StreamBuilder<Message>(
                stream: snapshot!.chatInterface.messagesStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: const LinearProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData) {
                    return const Text('No data');
                  }
                  modelResponse.write(snapshot.data?.chank ?? "");
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: GptMarkdown(
                      modelResponse.toString(),
                      textAlign: TextAlign.left,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
