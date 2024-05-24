import 'package:dio/dio.dart';

class ApiError implements Error {
  String? title;
  String? subtitle;
  String? type;
  int? statusCode;
  List<ApiError>? validationErrors;

  @override
  StackTrace? get stackTrace => StackTrace.current;

  ApiError({
    this.type,
    this.statusCode,
    this.title,
    this.subtitle,
    this.validationErrors,
  });

  ApiError.from(
    Map<String, dynamic> map,
    this.statusCode,
  )   : title = (map["errors"])?.first,
        subtitle = map["field"],
        type = map["type"];

  @override
  String toString() {
    return 'ApiError{title: $title, subtitle: $subtitle, type: $type, statusCode: $statusCode, validationErrors: $validationErrors}';
  }

  static String getErrorMessage(Response response) {
    return response.data['data']['message'] as String;
  }
}
