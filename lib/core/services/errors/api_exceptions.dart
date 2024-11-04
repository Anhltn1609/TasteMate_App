import 'package:tastemate_app/core/services/errors/api_error.dart';

enum ApiErrorType {
  network,
  badRequest,
  badResponse,
  unauthorized,
  cancel,
  timeout,
  server,
  unknown,
}

class ApiException implements Exception {
  final ApiError error;
  final ApiErrorType? errorType;

  ApiException({required this.error, this.errorType});
}
