import 'dart:io';

import 'package:flutter/foundation.dart';

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
  static String get baseUrl => 'http://167.99.239.52';

  // get baseUrl for current platform
  // static String get baseUrl =>
  // kIsWeb ?  'http://localhost:7272' : 'http://10.0.2.2:7272';

  static String recipes = '/recipes';
}
