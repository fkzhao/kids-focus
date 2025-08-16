
import 'package:flutter/material.dart';
import 'dart:math';

import 'detail_page.dart';

import 'list_page.dart';



class DiscoverTab extends ListPage<Map<String, String>> {
  const DiscoverTab({super.key});

  @override
  String? get title => '发现';

  @override
  Future<ListResult<Map<String, String>>> fetchData({bool loadMore = false}) async {
    await Future.delayed(const Duration(milliseconds: 3000));
    if (!loadMore) {
      // 只允许5条，不能再加载更多
      return ListResult(
        List.generate(10, (i) => {
          'image': 'https://picsum.photos/seed/${i + 1}/80/80',
          'title': '专注力训练${i + 1}',
          'desc': '这是第${i + 1}条内容，演示下拉刷新和加载更多。',
        }),
        true,
      );
    } else {
      // 不允许再加载更多
      return ListResult(
        List.generate(3, (i) => {
          'image': 'https://picsum.photos/seed/${i + 1}/80/80',
          'title': '专注力训练${i + 1}',
          'desc': '这是第${i + 1}条内容，演示下拉刷新和加载更多。',
        }),
        true,
      );
      
    }
  }

  @override
  Widget buildItem(BuildContext context, Map<String, String> item, int index) {
    return Column(
      children: [
        ListTile(
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
        ),
        const Divider(height: 1),
      ],
    );
  }
}

