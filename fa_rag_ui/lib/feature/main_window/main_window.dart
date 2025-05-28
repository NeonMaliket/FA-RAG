import 'package:fa_rag_ui/feature/main_window/model/model.dart';
import 'package:fa_rag_ui/feature/main_window/pages/pages.dart';
import 'package:flutter/material.dart';

final menuMap = [
  {'index': 0, 'title': 'Vector Database Selection', 'icon': Icons.data_array},
  {'index': 1, 'title': 'Model Selection', 'icon': Icons.model_training},
  {'index': 2, 'title': 'Data Upload & Vectorization', 'icon': Icons.upload},
  {'index': 3, 'title': 'Query Interface', 'icon': Icons.interests},
  {'index': 4, 'title': 'System Settings', 'icon': Icons.settings},
];

class MainWindow extends StatelessWidget {
  const MainWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final pageModel = PageModel();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('FA RAG'),
        leading: FloatingActionButton.small(
          child: Icon(Icons.menu),
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: MainWindowDrawer(pageModel: pageModel),
      body: MainWindowBody(pageModel: pageModel),
    );
  }
}

class MainWindowBody extends StatefulWidget {
  const MainWindowBody({super.key, required this.pageModel});
  final PageModel pageModel;

  @override
  State<MainWindowBody> createState() => _MainWindowBodyState();
}

class _MainWindowBodyState extends State<MainWindowBody> {
  late final PageController _pageController;
  late final Map<int, Widget> _pages;

  @override
  void initState() {
    _pages = {
      0: Text('Page: 0'),
      1: Text('Page: 1'),
      2: Text('Page: 2'),
      3: Text('Page: 3'),
      4: SettingsPage(),
    };
    _pageController = PageController(initialPage: 4);
    widget.pageModel.addListener(() {
      _pageController.jumpToPage(widget.pageModel.currentIndex);
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemBuilder: (context, index) {
        return Center(child: _pages[index]);
      },
    );
  }
}

class MainWindowDrawer extends StatelessWidget {
  const MainWindowDrawer({super.key, required this.pageModel});
  final PageModel pageModel;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: menuMap
            .map(
              (item) => InkWell(
                onTap: () {
                  pageModel.pageTo(item['index'] as int);
                },
                child: ListTile(
                  leading: Icon((item['icon'] as IconData)),
                  title: Text(item['title'] as String),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
