import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_overview/core/network/api_exception.dart';

void main() {
  DioException buildException(
    DioExceptionType type, {
    int? statusCode,
  }) {
    final requestOptions = RequestOptions(path: '/test');
    Response<dynamic>? response;
    if (statusCode != null) {
      response = Response<dynamic>(
        requestOptions: requestOptions,
        statusCode: statusCode,
      );
    }

    return DioException(
      requestOptions: requestOptions,
      type: type,
      response: response,
    );
  }

  test('maps timeout errors', () {
    final exception = buildException(DioExceptionType.connectionTimeout);
    final apiException = ApiException.fromDioException(exception);

    expect(apiException.type, ApiExceptionType.timeout);
    expect(
      apiException.message,
      'Connection timed out. Please try again.',
    );
    expect(apiException.statusCode, isNull);
  });

  test('maps connection errors', () {
    final exception = buildException(DioExceptionType.connectionError);
    final apiException = ApiException.fromDioException(exception);

    expect(apiException.type, ApiExceptionType.network);
    expect(
      apiException.message,
      'No internet connection. Please check your network.',
    );
  });

  test('maps 404 responses', () {
    final exception = buildException(
      DioExceptionType.badResponse,
      statusCode: 404,
    );
    final apiException = ApiException.fromDioException(exception);

    expect(apiException.type, ApiExceptionType.notFound);
    expect(apiException.message, 'Product not found.');
    expect(apiException.statusCode, 404);
  });

  test('maps server errors', () {
    final exception = buildException(
      DioExceptionType.badResponse,
      statusCode: 500,
    );
    final apiException = ApiException.fromDioException(exception);

    expect(apiException.type, ApiExceptionType.server);
    expect(apiException.message, 'Server error. Please try again later.');
    expect(apiException.statusCode, 500);
  });

  test('maps unknown errors', () {
    final exception = buildException(DioExceptionType.unknown);
    final apiException = ApiException.fromDioException(exception);

    expect(apiException.type, ApiExceptionType.unknown);
    expect(apiException.message, 'Something went wrong. Please try again.');
    expect(apiException.toString(), apiException.message);
  });
}
