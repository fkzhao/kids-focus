class AppConfig {
  static final AppConfig _instance = AppConfig._internal();

  // 这里可以添加全局配置项，例如API地址、主题色等
  String apiBaseUrl = 'https://httpbin.org/json';
  String appName = 'Kids Focus';

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();
}
