import 'package:flutter/material.dart';
import '../common/config.dart';

class BasePage extends StatelessWidget {
  final String? title;
  final bool showAppBar;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;

  const BasePage({
    super.key,
    this.title,
    this.showAppBar = true,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget? effectiveAppBar;
    if (showAppBar) {
      effectiveAppBar = appBar ?? AppBar(
        backgroundColor: AppConfig.navigationBarColor,
        foregroundColor: AppConfig.navigationBarTextColor,
        elevation: 0,
        title: Text(title ?? ''),
      );
    } else {
      effectiveAppBar = null;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: effectiveAppBar,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
