class BaseJsonModel {
  final int? code;
  final String? msg;
  final Map<String, dynamic> rawJson;

  BaseJsonModel(this.rawJson)
      : code = rawJson['code'] is int ? rawJson['code'] : int.tryParse(rawJson['code']?.toString() ?? ''),
        msg = rawJson['msg']?.toString();
}
