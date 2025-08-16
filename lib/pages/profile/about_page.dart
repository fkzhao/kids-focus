import 'package:flutter/material.dart';
import '../base_page.dart';
import '../../common/config.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '关于',
      body: const Center(child: Text('这里是关于页')),
    );
  }
}
