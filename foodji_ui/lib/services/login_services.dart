import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user_data_model.dart';

class LoginServices {
  String firebaseUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=";
  String baseUrl = "https://localhost:7272";

  // Login

  Future<String> login(email, password) async {
    http.Response res = await http.post(
        Uri.parse(firebaseUrl +
            await json.decode(await rootBundle.loadString(
                    '../foodji-auth-firebase-adminsdk-ulcr8-d5a92dbcff.json'))[
                "private_key"]),
        body: {email: email, password: password});
    try {
      if (res.statusCode == 200) {
        return json.decode(res.body).secureToken;
      } else {
        throw res.statusCode;
      }
    } catch (e) {
      return "";
    }
  }

  // GET
  // User data
  Future<UserDataModel> getUserData(email) async {
    var apiUrl = '/usersData/$email';
    http.Response res = await http.get(Uri.parse(baseUrl + apiUrl));
    try {
      if (res.statusCode == 200) {
        return UserDataModel.fromJson(json.decode(res.body));
      } else {
        throw res.statusCode;
      }
    } catch (e) {
      return UserDataModel(id: "", recipes: []);
    }
  }
}
