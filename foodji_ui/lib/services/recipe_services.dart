import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodji_ui/models/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../misc/app_routes.dart';

class RecipeServices {
  AppRoutes appRoutes = AppRoutes("");

  // GET
  // Recipes
  Future<List<RecipeModel>> getRecipes() async {
    appRoutes =
        AppRoutes(await FirebaseAuth.instance.currentUser!.getIdToken());

    // FOR IT TO WORK:
    // https://stackoverflow.com/questions/65630743/how-to-solve-flutter-web-api-cors-error-only-with-dart-code
    http.Response res = await http.get(
        Uri.parse('${AppRoutes.baseUrl}${AppRoutes.recipes}'),
        headers: appRoutes.headers());

    try {
      if (res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body);
        return list.map<RecipeModel>((e) => RecipeModel.fromJson(e)).toList();
      } else {
        throw res.statusCode;
      }
    } catch (e) {
      return <RecipeModel>[];
    }
  }

  // PUT
  // Recipes
  updateRecipe(RecipeModel recipe) async {
    var res = await http.put(
        Uri.parse('${AppRoutes.baseUrl}${AppRoutes.recipes}'),
        headers: appRoutes.headers(),
        body: jsonEncode(recipe));

    if (res.statusCode == 200) {
    } else {
      throw 'Recipe update returned ${res.statusCode}';
    }
  }

  // POST
  // Recipes
  createRecipe(RecipeModel recipe) async {
    var res = await http.post(
        Uri.parse('${AppRoutes.baseUrl}${AppRoutes.recipes}'),
        headers: appRoutes.headers(),
        body: jsonEncode(recipe));

    if (res.statusCode == 200) {
    } else {
      throw 'Recipe creation returned ${res.statusCode}';
    }
  }
}
