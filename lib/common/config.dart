import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class AppConfig {
  static const String appName = 'Your App Name';
  static const String apiUrl = 'https://httpbin.org/json';
  static const bool isProduction = kReleaseMode;

  // 全局主色
  static const Color primaryColor = Colors.white; // lightGreen
  // 顶部导航栏颜色
  static const Color navigationBarColor = Colors.white;
  // 底部选中颜色
  static const Color bottomBarSelectedColor = Color(0xFF8E97FD); // #8E97FD
  // 底部未选中颜色
  static const Color bottomBarUnselectedColor = Colors.grey;
  // 顶部导航栏文字颜色
  static const Color navigationBarTextColor = Colors.black;
}