import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodji_ui/models/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../misc/app_routes.dart';

class RecipeServices {
  AppRoutes appRoutes = AppRoutes("");

  // GET
  Future<List<RecipeModel>> getRecipes() async {
    appRoutes =
        AppRoutes(await FirebaseAuth.instance.currentUser!.getIdToken());
    http.Response res = await http.get(
        Uri.parse('${AppRoutes.baseUrl}${AppRoutes.recipes}'),
        headers: appRoutes.headers());

    if (res.statusCode == 200) {
      List<dynamic> list = json.decode(res.body);
      return list.map<RecipeModel>((e) => RecipeModel.fromJson(e)).toList();
    } else {
      return <RecipeModel>[];
    }
  }

  // PUT
  updateRecipe(RecipeModel recipe) async {
    return await http.put(Uri.parse('${AppRoutes.baseUrl}${AppRoutes.recipes}'),
        headers: appRoutes.headers(), body: jsonEncode(recipe));
  }

  // POST
  createRecipe(RecipeModel recipe) async {
    return await http.post(
        Uri.parse('${AppRoutes.baseUrl}${AppRoutes.recipes}'),
        headers: appRoutes.headers(),
        body: jsonEncode(recipe));
  }

  // DELETE
  deleteRecipe(String recipeId) async {
    return await http.post(
        Uri.parse('${AppRoutes.baseUrl}${AppRoutes.recipes}/$recipeId'),
        headers: appRoutes.headers());
  }
}
