class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://fakestoreapi.com';
  static const String productsEndpoint = '/products';

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
}

/// Breakpoints for responsive design
class Breakpoints {
  Breakpoints._();

  /// Mobile breakpoint (< 600px)
  static const double mobile = 600;

  /// Tablet breakpoint (600-900px)
  static const double tablet = 900;

  /// Get grid cross axis count based on screen width
  static int getCrossAxisCount(double width) {
    if (width < mobile) return 1;
    if (width < tablet) return 2;
    return 4;
  }

  static bool isMobile(double width) => width < mobile;
  static bool isTablet(double width) => width >= mobile && width < tablet;
  static bool isDesktop(double width) => width >= tablet;
}