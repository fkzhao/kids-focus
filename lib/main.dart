import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kids_focus/common/logger.dart';
import 'pages/home_tab.dart';
import 'pages/discover_tab.dart';
import 'pages/profile_tab.dart';
import 'pages/schulte_grid_tab.dart';
import 'common/config.dart';

void main() {
  runApp(const MyApp());
  configLoading();
  LogUtil.init(isDebug: true);
  LogUtil.v('App started');
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..maskColor = Colors.black.withAlpha(100);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bottom TabBar Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainPage(),
      builder: EasyLoading.init(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeTab(),
    DiscoverTab(),
    SchulteGridTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class _CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _CustomBottomBar({required this.currentIndex, required this.onTap});

  final List<_TabItemData> _items = const [
    _TabItemData('首页', Icons.home_outlined, Icons.home),
    _TabItemData('发现', Icons.explore_outlined, Icons.explore),
    _TabItemData('舒尔特', Icons.grid_4x4_outlined, Icons.grid_4x4),
    _TabItemData('我的', Icons.person_outline, Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Container(
      height: 62 + bottom,
      decoration: BoxDecoration(
        color: AppConfig.navigationBarColor,
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (i) {
            final selected = i == currentIndex;
            final item = _items[i];
            return Expanded(
              child: GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.only(top: 6, bottom: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        selected ? item.activeIcon : item.icon,
                        color: selected ? AppConfig.bottomBarSelectedColor : AppConfig.bottomBarUnselectedColor,
                        size: 24,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.label,
                        style: TextStyle(
                          color: selected ? AppConfig.bottomBarSelectedColor : AppConfig.bottomBarUnselectedColor,
                          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _TabItemData {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  const _TabItemData(this.label, this.icon, this.activeIcon);
}
