import 'package:foodji_ui/models/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeServices {
  String baseUrl = "https://localhost:7272";

  // GET
  // Recipes
  Future<List<RecipeModel>> getRecipes() async {
    var apiUrl = '/recipes';
    http.Response res = await http.get(Uri.parse(baseUrl + apiUrl));
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
}