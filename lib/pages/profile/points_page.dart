import 'package:flutter/material.dart';
import '../base_page.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '积分',
      body: const Center(child: Text('这里是积分查看页')),
    );
  }
}
