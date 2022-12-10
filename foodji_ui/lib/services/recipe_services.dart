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

  // POST
  createRecipe(RecipeModel recipe) async {
    recipe.createdAt = DateTime.now();
    recipe.details.totalTime = (recipe.details.preparationTime ?? 0) +
        (recipe.details.cookingTime ?? 0) +
        (recipe.details.restingTime ?? 0);
    appRoutes =
        AppRoutes(await FirebaseAuth.instance.currentUser!.getIdToken());
    return await http.post(
        Uri.parse('${AppRoutes.baseUrl}${AppRoutes.recipes}'),
        headers: appRoutes.headers(),
        body: jsonEncode(recipe));
  }

  // PUT
  updateRecipe(RecipeModel recipe) async {
    recipe.createdAt ??= DateTime.now();
    recipe.details.totalTime = (recipe.details.preparationTime ?? 0) +
        (recipe.details.cookingTime ?? 0) +
        (recipe.details.restingTime ?? 0);
    appRoutes =
        AppRoutes(await FirebaseAuth.instance.currentUser!.getIdToken());
    return await http.put(
        Uri.parse('${AppRoutes.baseUrl}${AppRoutes.recipes}/${recipe.id}'),
        headers: appRoutes.headers(),
        body: jsonEncode(recipe));
  }

  // DELETE
  deleteRecipe(RecipeModel recipe) async {
    appRoutes =
        AppRoutes(await FirebaseAuth.instance.currentUser!.getIdToken());
    return await http.delete(
        Uri.parse('${AppRoutes.baseUrl}${AppRoutes.recipes}/${recipe.id}'),
        headers: appRoutes.headers());
  }
}
