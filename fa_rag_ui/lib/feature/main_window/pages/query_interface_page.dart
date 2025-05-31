import 'package:fa_rag_ui/components/components.dart';
import 'package:fa_rag_ui/feature/main_window/pages/abstract_page.dart';
import 'package:fa_rag_ui/test_utils/constatns.dart';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class QueryPage extends StatelessWidget {
  const QueryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AbstractPage(
      title: 'Query Interface',
      actions: [
        MiniSelect(
          items: ['Ollama', 'OpenAI', 'Image Service'],
          lable: 'Chat Interface',
          icon: Icon(Icons.model_training),
          onChanged: (index) {},
        ),
        SizedBox(height: 25),
        MiniSelect(
          items: ['GPT-3.55555555555555555555', 'GPT-4o', 'GPT-4'],
          lable: 'Model',
          icon: Icon(Icons.rocket),
          onChanged: (index) {},
        ),
      ],
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar.medium(
            collapsedHeight: 75,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 100,
            expandedHeight: 75.0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              expandedTitleScale: 1,
              title: Row(
                spacing: 10,
                children: [
                  Expanded(
                    flex: 9,
                    child: Form(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'User Message'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(56, 56),
                      ),
                      onPressed: () {},
                      child: Icon(Icons.send, size: 21),
                    ),
                  ),
                ],
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
                    return Center(child: const CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData) {
                    return const Text('No data');
                  }

                  return GptMarkdown(snapshot.data!, textAlign: TextAlign.left);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
