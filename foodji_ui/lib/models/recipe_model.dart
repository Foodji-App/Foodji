// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:foodji_ui/models/recipe_details_model.dart';

import 'categories_enum.dart';
import 'recipe_ingredient_model.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class RecipeModel {
  String? id;
  String name;
  String imageUri;
  String category;
  String description;
  RecipeDetailsModel details;
  List<RecipeIngredientModel> ingredients;
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
      required this.ingredients,
      required this.steps,
      required this.isFavorite,
      this.createdAt});

  /// Connect the generated [_$RecipeModelFromJson] function to the `fromJson`
  /// factory.
  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);

  /// Connect the generated [_$RecipeModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);

  String toText() =>
      'id: $id\n' +
      'name: $name\n' +
      'img: $imageUri\n' +
      'category: $category\n' +
      'desc: $description\n' +
      'details: ${details.toText()}\n' +
      'isFavorite: ${isFavorite.toString()}' +
      'ingredients: \n - ${ingredients.join('\n - ')}\n\n' +
      'steps: \n - ${steps.join('\n - ')}\n';

  bool equals(RecipeModel other) =>
      id == other.id &&
      name == other.name &&
      imageUri == other.imageUri &&
      category == other.category &&
      description == other.description &&
      details.equals(other.details) &&
      _equalsIngredients(other.ingredients) &&
      _equalsSteps(other.steps) &&
      isFavorite == other.isFavorite;

  bool _equalsIngredients(List<RecipeIngredientModel> otherIngredients) {
    if (ingredients.length != otherIngredients.length) {
      return false;
    }

    for (var i = 0; i < ingredients.length; i++) {
      if (!ingredients[i].equals(otherIngredients[i])) {
        return false;
      }
    }
    return true;
  }

  bool _equalsSteps(List<String> other) {
    if (steps.length != other.length) return false;

    for (var i = 0; i < steps.length; i++) {
      if (steps[i] != other[i]) {
        return false;
      }
    }
    return true;
  }

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
        ingredients: [],
        steps: [],
        isFavorite: false);
  }

  static RecipeModel deepCopy(RecipeModel model) {
    return RecipeModel(
        id: model.id,
        name: model.name,
        imageUri: model.imageUri,
        category: model.category,
        description: model.description,
        details: RecipeDetailsModel.deepCopy(model.details),
        ingredients: RecipeIngredientModel.deepCopy(model.ingredients),
        steps: model.steps,
        isFavorite: model.isFavorite);
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
        ingredients:
            RecipeIngredientModel.getSamples(random.integer(10, min: 3)),
        steps: faker.lorem.sentences(random.integer(10, min: 3)),
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
