import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../common/config.dart';
import '../utils/http_service.dart';
import '../models/base_json_model.dart';
import 'base_page.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  BaseJsonModel? _model;
  String? _error;

  Future<void> _fetchData() async {
    _error = null;
    EasyLoading.show(status: '加载中...');
    try {
      final model = await HttpService.getJsonModel(AppConfig.apiUrl);
      setState(() {
        _model = model;
      });
      EasyLoading.dismiss();
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
      EasyLoading.showError('请求失败:\n$_error');
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '首页',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlatformElevatedButton(onPressed: _fetchData, child: const Text('获取数据')),
            const SizedBox(height: 24),
            if (_model != null)
              Text('code: \\${_model!.code}\nmsg: \\${_model!.msg}'),
            // 错误信息用EasyLoading弹窗提示，无需页面显示
          ],
        ),
      ),
    );
  }
}
