import 'package:fa_rag_ui/components/ai/chat_snapshot_select.dart';
import 'package:fa_rag_ui/core/domain/chat_snapshot.dart';
import 'package:fa_rag_ui/feature/main_window/pages/abstract_page.dart';
import 'package:fa_rag_ui/test_utils/constatns.dart';
import 'package:fa_rag_ui/theme/rag_theme.dart';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class QueryPage extends StatelessWidget {
  const QueryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AbstractPage(
      title: 'Query Interface',
      actions: [
        ChatSnapshotSelect(
          onSnapshotSelected: (ChatSnapshot? snap) {
            print("From query: ${snap?.title}");
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
                                    onPressed: () {},
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
              return FutureBuilder(
                future: markdown(),
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

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: GptMarkdown(
                      snapshot.data!,
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
