import 'package:flutter/material.dart';
import 'profile/settings_page.dart';
import 'profile/about_page.dart';
import 'profile/points_page.dart';
import 'base_page.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final double topHeight = MediaQuery.of(context).size.height * 0.33;
    final items = [
      {
        'icon': Icons.settings,
        'title': '设置',
        'onTap': () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SettingsPage()),
        ),
      },
      {
        'icon': Icons.info_outline,
        'title': '关于',
        'onTap': () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AboutPage()),
        ),
      },
      {
        'icon': Icons.stars,
        'title': '积分查看',
        'onTap': () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const PointsPage()),
        ),
      },
    ];

    return BasePage(
      showAppBar: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: const Color(0xFFE0F7FA),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: items.length + 2, // 头像区+间距+条目+结尾间距
              itemBuilder: (context, index) {
                if (index == 0) {
                  // 头像区
                  return Column(
                    children: [
                      Container(
                        height: topHeight,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 32),
                            CircleAvatar(
                              radius: 62,
                              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
                            ),
                            const SizedBox(height: 24),
                            const Text('用户名', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  );
                } else if (index == items.length + 1) {
                  return const SizedBox(height: 24);
                } else {
                  final item = items[index - 1];
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(item['icon'] as IconData, color: Colors.lightGreen),
                        title: Text(item['title'] as String),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: item['onTap'] as void Function(),
                      ),
                      if (index != items.length) const _IndentedDivider(),
                    ],
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class _IndentedDivider extends StatelessWidget {
  const _IndentedDivider();
  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      indent: 15,
      endIndent: 0,
      thickness: 1,
    );
  }
}
