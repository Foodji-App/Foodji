// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'dart:math';

import 'package:faker/faker.dart';
import 'package:foodji_ui/models/recipe_details_model.dart';

import 'categories_enum.dart';
import 'recipe_ingredient_model.dart';

class RecipeModel {
  String id;
  String name;
  String imageUri;
  String category;
  String description;
  RecipeDetailsModel details;
  List<RecipeIngredientModel> recipeIngredients;
  List<String> steps;
  DateTime? createdAt;
  bool isFavorite;

  RecipeModel(
      {required this.id,
      required this.name,
      required this.imageUri,
      required this.category,
      required this.description,
      required this.details,
      required this.recipeIngredients,
      required this.steps,
      required this.createdAt,
      required this.isFavorite});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'],
        category: json['category'],
        description: json['description'],
        details: RecipeDetailsModel.fromJson(json['details']),
        recipeIngredients: json['recipeIngredients']
            .map<RecipeIngredientModel>(
                (e) => RecipeIngredientModel.fromJson(e))
            .toList(),
        steps: json['steps'].cast<String>(),
        imageUri: json['imageUri'],
        isFavorite: Random.secure().nextBool());
  }

  toText() =>
      'id: $id\n' +
      'name: $name\n' +
      'img: $imageUri\n' +
      'category: $category\n' +
      'desc: $imageUri\n' +
      'details: ${details.toText()}\n' +
      'ingredients: \n ${recipeIngredients.join('\n - ')}\n' +
      'steps: \n ${steps.join('\n - ')}\n' +
      'createdAt: $createdAt' +
      'isFavorite: ${isFavorite.toString()}';

  static RecipeModel newRecipeModel() {
    return RecipeModel(
        id: '',
        name: '',
        imageUri: '',
        category: '',
        description: '',
        details: RecipeDetailsModel(
            cookingTime: 0,
            preparationTime: 0,
            restingTime: 0,
            serves: 0,
            totalTime: 0),
        recipeIngredients: [],
        steps: [],
        createdAt: DateTime.now(),
        isFavorite: false);
  }

  static RecipeModel getSample() {
    var faker = Faker();

    return RecipeModel(
        id: faker.guid.random.string(16), // Not Fail Safe
        name: faker.food.dish(),
        imageUri: "https://picsum.photos/seed/${faker.food.dish()}/500/300",
        category: Categories.values[random.integer(5, min: 0)].name,
        description: faker.lorem.sentences(random.integer(4, min: 1)).join(' '),
        details: RecipeDetailsModel.getSample(),
        recipeIngredients:
            RecipeIngredientModel.getSamples(random.integer(10, min: 3)),
        steps: faker.lorem.sentences(random.integer(10, min: 3)),
        createdAt: faker.date.dateTime(),
        isFavorite: Random().nextInt(2) == 1 ? true : false);
  }

  static List<RecipeModel> getSamples(int amount) {
    var samples = <RecipeModel>[];

    for (var i = 0; i < amount; i++) {
      samples.add(getSample());
    }
    return samples;
  }
}
