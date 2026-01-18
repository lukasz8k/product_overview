import 'package:flutter_test/flutter_test.dart';
import 'package:product_overview/core/constants/app_constants.dart';

void main() {
  group('ApiConstants', () {
    test('exposes base configuration values', () {
      expect(ApiConstants.baseUrl, 'https://fakestoreapi.com');
      expect(ApiConstants.productsEndpoint, '/products');
      expect(ApiConstants.connectTimeout, const Duration(seconds: 10));
      expect(ApiConstants.receiveTimeout, const Duration(seconds: 10));
    });
  });

  group('Breakpoints', () {
    test('calculates cross axis count for widths', () {
      expect(Breakpoints.getCrossAxisCount(320), 1);
      expect(Breakpoints.getCrossAxisCount(600), 2);
      expect(Breakpoints.getCrossAxisCount(899), 2);
      expect(Breakpoints.getCrossAxisCount(900), 4);
    });

    test('identifies device sizes at boundaries', () {
      expect(Breakpoints.isMobile(599), isTrue);
      expect(Breakpoints.isMobile(600), isFalse);

      expect(Breakpoints.isTablet(600), isTrue);
      expect(Breakpoints.isTablet(899), isTrue);
      expect(Breakpoints.isTablet(900), isFalse);

      expect(Breakpoints.isDesktop(899), isFalse);
      expect(Breakpoints.isDesktop(900), isTrue);
    });
  });
}
