import 'package:dio/dio.dart';

enum ApiExceptionType { network, timeout, server, notFound, unknown }

class ApiException implements Exception {
  final String message;
  final ApiExceptionType type;
  final int? statusCode;

  ApiException({required this.message, required this.type, this.statusCode});

  factory ApiException.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: 'Connection timed out. Please try again.',
          type: ApiExceptionType.timeout,
        );
      case DioExceptionType.connectionError:
        return ApiException(
          message: 'No internet connection. Please check your network.',
          type: ApiExceptionType.network,
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return ApiException(
            message: 'Product not found.',
            type: ApiExceptionType.notFound,
            statusCode: statusCode,
          );
        }
        return ApiException(
          message: 'Server error. Please try again later.',
          type: ApiExceptionType.server,
          statusCode: statusCode,
        );
      default:
        return ApiException(
          message: 'Something went wrong. Please try again.',
          type: ApiExceptionType.unknown,
        );
    }
  }

  @override
  String toString() => message;
}
