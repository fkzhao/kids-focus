import 'package:flutter/material.dart';
import '../base_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '设置',
      body: const Center(child: Text('这里是设置页')),
    );
  }
}
