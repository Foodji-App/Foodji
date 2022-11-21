import 'package:foodji_ui/models/recipe_model.dart';

class UserDataModel {
  String id;
  List<RecipeModel> recipes;

  UserDataModel({
    required this.id,
    required this.recipes,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
        id: json['id'],
        recipes: json['recipes']
            .map<RecipeModel>((e) => RecipeModel.fromJson(e))
            .toList());
  }
}
