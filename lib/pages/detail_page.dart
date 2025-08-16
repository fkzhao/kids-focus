import 'package:flutter/material.dart';
import 'base_page.dart';

class DetailPage extends StatelessWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // mock数据，实际可根据id请求
    final mockDetail = {
      'avatar': 'https://i.pravatar.cc/120?img=${int.tryParse(id) ?? 1}',
      'title': '内容标题 $id',
      'desc': '这里是内容 $id 的详细描述，支持多行文本展示。',
    };

    return BasePage(
      showAppBar: false,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 48), // 给返回按钮留空间
                CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage(mockDetail['avatar']!),
                ),
                const SizedBox(height: 24),
                Text(
                  mockDetail['title']!,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  mockDetail['desc']!,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            top: 64,
            left: 34,
            child: Material(
              color: Colors.transparent,
              elevation: 8,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => Navigator.of(context).maybePop(),
                child: Ink(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.black87),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
