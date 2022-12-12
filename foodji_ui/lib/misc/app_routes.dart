import 'dart:io';

class AppRoutes {
  AppRoutes(this.token);
  var token = '';
  Map<String, String> headers() {
    return {
      HttpHeaders.authorizationHeader: 'bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.accessControlAllowOriginHeader: '*',
      HttpHeaders.accessControlAllowMethodsHeader: 'POST, GET, PUT, DELETE'
    };
  }

  // get baseUrl for production
  // static String baseUrl => 'http://167.99.239.52';

  // get baseUrl for current platform
  static String get baseUrl =>
      Platform.isAndroid ? 'http://10.0.2.2:7272' : 'http://localhost:7272';

  static String recipes = '/recipes';
}
