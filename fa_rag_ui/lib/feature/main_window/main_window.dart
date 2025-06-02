import 'package:fa_rag_ui/feature/main_window/model/model.dart';
import 'package:fa_rag_ui/feature/main_window/pages/pages.dart';
import 'package:fa_rag_ui/theme/rag_theme.dart';
import 'package:flutter/material.dart';

final menuMap = [
  {'index': 0, 'title': 'Vector Database Selection', 'icon': Icons.data_array},
  {'index': 1, 'title': 'Model Configuration', 'icon': Icons.model_training},
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

    return MainPageProvider(
      pageModel: pageModel,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('FA RAG'),
          leading: InkWell(
            child: Icon(Icons.menu, color: context.theme().primaryColor),
            onTap: () => scaffoldKey.currentState?.openDrawer(),
          ),
        ),
        drawer: MainWindowDrawer(),
        body: MainWindowBody(),
      ),
    );
  }
}

class MainWindowBody extends StatefulWidget {
  const MainWindowBody({super.key});

  @override
  State<MainWindowBody> createState() => _MainWindowBodyState();
}

class _MainWindowBodyState extends State<MainWindowBody> {
  late final PageController _pageController;
  late final Map<int, Widget> _pages;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _pages = {
      0: Text('Page: 0'),
      1: ModelConfiguration(),
      2: Text('Page: 2'),
      3: QueryPage(),
      4: SettingsPage(),
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final pageModel = MainPageProvider.of(context);

      _pageController = PageController(initialPage: pageModel.currentIndex);
      pageModel.addListener(() {
        _pageController.jumpToPage(pageModel.currentIndex);
        setState(() {});
      });
      _initialized = true;
    }
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
  const MainWindowDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final pageModel = MainPageProvider.of(context);
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
                  leading: Icon(
                    (item['icon'] as IconData),
                    color: item['index'] == pageModel.currentIndex
                        ? context.theme().colorScheme.secondary
                        : context.theme().primaryColor,
                  ),
                  title: Text(item['title'] as String),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
