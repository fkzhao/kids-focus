import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kids_focus/app_config.dart';
import '../utils/http_service.dart';
import '../models/base_json_model.dart';

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
      final model = await HttpService.getJsonModel(AppConfig().apiBaseUrl);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text('获取数据'),
            ),
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
