import 'dart:io';

class AppRoutes {
  AppRoutes(this.token);
  var token = "";
  Map<String, String> headers() {
    return {
      HttpHeaders.authorizationHeader: 'bearer $token',
      HttpHeaders.contentEncodingHeader: 'application/json; charset=UTF-8',
      HttpHeaders.accessControlAllowOriginHeader: "*",
      HttpHeaders.accessControlAllowMethodsHeader: "POST, GET, PUT, DELETE"
    };
  }

  static String baseUrl = 'https://localhost:7272';
  static String recipes = '/recipes';
}
