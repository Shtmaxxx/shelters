import '../../../shared_models/api/api_error.dart';

///Api errors custom exception
class ApiException implements Exception {
  final List<ApiError>? apiErrors;

  ApiException(this.apiErrors);

  @override
  String toString() {
    return apiErrors?.first.validationErrors?.first.title ?? '';
  }
}
