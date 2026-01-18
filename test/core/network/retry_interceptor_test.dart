import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_overview/core/network/retry_interceptor.dart';

class SequenceAdapter implements HttpClientAdapter {
  SequenceAdapter(this._handlers);

  final List<Future<ResponseBody> Function(RequestOptions options)> _handlers;
  int fetchCount = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    fetchCount++;
    if (_handlers.isEmpty) {
      return ResponseBody.fromString('OK', 200);
    }

    final handler = _handlers.removeAt(0);
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

Dio buildDio(SequenceAdapter adapter, {int maxRetries = 3}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://example.com',
      responseType: ResponseType.json,
    ),
  );
  dio.httpClientAdapter = adapter;
  dio.interceptors.add(
    RetryInterceptor(
      dio: dio,
      maxRetries: maxRetries,
      retryDelays: List<Duration>.filled(maxRetries, Duration.zero),
    ),
  );
  return dio;
}

void main() {
  test('retries on connection timeout and succeeds', () async {
    final adapter = SequenceAdapter([
      (options) async => throw DioException(
            requestOptions: options,
            type: DioExceptionType.connectionTimeout,
          ),
      (options) async => ResponseBody.fromString(
            '{"ok": true}',
            200,
            headers: {
              Headers.contentTypeHeader: ['application/json'],
            },
          ),
    ]);

    final dio = buildDio(adapter, maxRetries: 2);
    final response = await dio.get<Map<String, dynamic>>('/test');

    expect(response.statusCode, 200);
    expect(response.data, isA<Map<String, dynamic>>());
    expect(adapter.fetchCount, 2);
  });

  test('does not retry on 400 responses', () async {
    final adapter = SequenceAdapter([
      (options) async => ResponseBody.fromString(
            'Bad Request',
            400,
            headers: {
              Headers.contentTypeHeader: ['text/plain'],
            },
          ),
    ]);

    final dio = buildDio(adapter, maxRetries: 2);

    try {
      await dio.get('/test');
      fail('Expected DioException');
    } on DioException {
      expect(adapter.fetchCount, 1);
    }
  });

  test('retries on 500 responses and stops after max retries', () async {
    final adapter = SequenceAdapter([
      (options) async => ResponseBody.fromString('error', 500),
      (options) async => ResponseBody.fromString('error', 500),
      (options) async => ResponseBody.fromString('error', 500),
    ]);

    final dio = buildDio(adapter, maxRetries: 2);

    try {
      await dio.get('/test');
      fail('Expected DioException');
    } on DioException catch (error) {
      expect(error.response?.statusCode, 500);
      expect(adapter.fetchCount, 3);
    }
  });
}
