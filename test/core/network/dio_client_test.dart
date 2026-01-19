import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_overview/core/constants/app_constants.dart';
import 'package:product_overview/core/network/dio_client.dart';

void main() {
  test('creates a singleton Dio instance', () {
    final first = DioClient.instance;
    final second = DioClient.instance;

    expect(identical(first, second), isTrue);
  });

  test('configures base options from constants', () {
    final dio = DioClient.instance;

    expect(dio.options.baseUrl, ApiConstants.baseUrl);
    expect(dio.options.connectTimeout, ApiConstants.connectTimeout);
    expect(dio.options.receiveTimeout, ApiConstants.receiveTimeout);
    expect(dio.options.headers['Content-Type'], 'application/json');
    expect(dio.options.headers['Accept'], 'application/json');
  });

  test('registers retry interceptor and log interceptor when debugging', () {
    final dio = DioClient.instance;

    expect(dio.interceptors.any((interceptor) => interceptor is RetryInterceptor), isTrue);

    final hasLogInterceptor = dio.interceptors.any((interceptor) => interceptor is LogInterceptor);
    expect(hasLogInterceptor, kDebugMode);
  });
}