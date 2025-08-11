
import 'package:flutter/material.dart';

import 'detail_page.dart';

class DiscoverTab extends StatelessWidget {
  const DiscoverTab({super.key});

  @override
  Widget build(BuildContext context) {
  final List<Map<String, String>> mockData = [
      {
        'image': 'https://picsum.photos/seed/1/80/80',
        'title': '儿童专注力训练1',
        'desc': '提升孩子专注力的小游戏和方法。',
      },
      {
        'image': 'https://picsum.photos/seed/2/80/80',
        'title': '亲子互动课程',
        'desc': '和孩子一起成长，增进亲子关系。',
      },
      {
        'image': 'https://picsum.photos/seed/3/80/80',
        'title': '科学睡眠习惯',
        'desc': '帮助孩子养成良好作息。',
      },
      {
        'image': 'https://picsum.photos/seed/4/80/80',
        'title': '情绪管理',
        'desc': '教孩子正确表达和管理情绪。',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('发现'),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: ListView.separated(
        itemCount: mockData.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = mockData[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(item['image']!, width: 60, height: 60, fit: BoxFit.cover),
            ),
            title: Text(item['title'] ?? ''),
            subtitle: Text(item['desc'] ?? ''),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    id: index.toString(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
