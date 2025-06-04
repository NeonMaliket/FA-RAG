import 'package:fa_rag_core/core/core.dart';
import 'package:fa_rag_ui/feature/main_window/model/model.dart';
import 'package:fa_rag_ui/feature/main_window/pages/pages.dart';
import 'package:fa_rag_ui/theme/rag_theme.dart';
import 'package:flutter/material.dart';

enum _MenuItemType {
  vectorDatabaseSelection,
  modelConfiguration,
  dataUploadAndVectorization,
  queryInterface,
  systemSettings,
}

class _Menu {
  final int index;
  final String title;
  final IconData icon;
  final _MenuItemType type;

  _Menu({
    required this.index,
    required this.title,
    required this.icon,
    required this.type,
  });
}

final menuList = [
  _Menu(
    index: 0,
    title: 'Vector Database Selection',
    icon: Icons.data_array,
    type: _MenuItemType.vectorDatabaseSelection,
  ),
  _Menu(
    index: 1,
    title: 'Model Configuration',
    icon: Icons.model_training,
    type: _MenuItemType.modelConfiguration,
  ),
  _Menu(
    index: 2,
    title: 'Data Upload & Vectorization',
    icon: Icons.upload,
    type: _MenuItemType.dataUploadAndVectorization,
  ),
  _Menu(
    index: 3,
    title: 'Query Interface',
    icon: Icons.interests,
    type: _MenuItemType.queryInterface,
  ),
  _Menu(
    index: 4,
    title: 'System Settings',
    icon: Icons.settings,
    type: _MenuItemType.systemSettings,
  ),
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
    final snapshotPool = ChatSnapshotPoolProvider.of(context);
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: menuList
            .map(
              (item) => InkWell(
                onTap:
                    snapshotPool.isEmpty() &&
                        item.type == _MenuItemType.queryInterface
                    ? null
                    : () {
                        pageModel.pageTo(item.index);
                      },
                child: ListTile(
                  leading: Icon(
                    item.icon,
                    color: _menuItemColor(
                      item,
                      pageModel.currentIndex,
                      context,
                      snapshotPool,
                    ),
                  ),
                  title: Text(item.title),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Color? _menuItemColor(
    _Menu item,
    int currentIndex,
    BuildContext context,
    ChatSnapshotPool snapshotPool,
  ) {
    if (item.index == currentIndex) {
      return context.theme().colorScheme.secondary;
    } else if (item.type == _MenuItemType.queryInterface) {
      if (snapshotPool.isEmpty()) {
        return context.theme().dividerColor;
      }
    }
    return context.theme().primaryColor;
  }
}
