
import 'package:dio/dio.dart';
import '../models/base_json_model.dart';

class HttpService {
  static final Dio _dio = Dio();

  /// 发送GET请求，返回BaseJsonModel对象
  static Future<BaseJsonModel> getJsonModel(String path) async {
    try {
      final response = await _dio.get(path);
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return BaseJsonModel(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      rethrow;
    }
  }
}
