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

  static String baseUrl = 'http://localhost:7272';
  static String recipes = '/recipes';
}
