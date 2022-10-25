// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';

import 'ingredient_model.dart';

class RecipeModel {
  int id;
  String name;
  String category;
  String description;
  RecipeDetailsModel details;
  List<IngredientModel> ingredients;
  List<String> steps;

  String imageUri; // TODO remove???
  bool isFavorite; // TODO remove???

  RecipeModel(
      {required this.id,
      required this.name,
      required this.imageUri,
      required this.category,
      required this.description,
      required this.details,
      required this.ingredients,
      required this.steps,
      required this.isFavorite});

  // TODO when recieved from server
  //factory RecipeModel.fromJson(Map<String, dynamic> json) {
  //   return RecipeModel();
  // }

  String toText() =>
      'id: ${id.toString()}\n' +
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
      details == other.details &&
      _equalsIngredients(other.ingredients) &&
      _equalsSteps(other.steps) &&
      isFavorite == other.isFavorite;

  bool _equalsIngredients(List<IngredientModel> otherIngredients) {
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
      if (steps[i] != other[i]) return false;
    }
    return true;
  }

  static RecipeModel newRecipeModel() {
    return RecipeModel(
        id: 0,
        name: '',
        imageUri: '',
        category: '',
        description: '',
        details: RecipeDetailsModel.newRecipeModel(),
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
        ingredients: IngredientModel.deepCopy(model.ingredients),
        steps: model.steps,
        isFavorite: model.isFavorite);
  }

  static RecipeModel getSample() {
    var faker = Faker();

    return RecipeModel(
        id: faker.guid.random.integer(99999999), // Not Fail Safe
        name: faker.food.dish(),
        imageUri: "https://picsum.photos/seed/${faker.food.dish()}/500/300",
        category: faker.food.cuisine(),
        description: faker.lorem.sentences(random.integer(4, min: 1)).join(' '),
        details: RecipeDetailsModel.getSample(),
        ingredients: IngredientModel.getSamples(random.integer(10, min: 3)),
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

class RecipeDetailsModel {
  int preparationTime;
  int cookingTime;
  int serves;

  int get totalTime => preparationTime + cookingTime;

  RecipeDetailsModel({
    required this.preparationTime,
    required this.cookingTime,
    required this.serves,
  });

  toText() =>
      'prepTime: $preparationTime\ncookTime: $cookingTime\nserves: $serves\n';

  bool equals(RecipeDetailsModel other) {
    return preparationTime == other.preparationTime &&
        cookingTime == other.cookingTime &&
        serves == other.serves;
  }

  static RecipeDetailsModel newRecipeModel() {
    return RecipeDetailsModel(
      preparationTime: 0,
      cookingTime: 0,
      serves: 0,
    );
  }

  static RecipeDetailsModel getSample() {
    return RecipeDetailsModel(
        preparationTime: random.integer(90, min: 15),
        cookingTime: random.integer(270, min: 15),
        serves: random.integer(8, min: 1));
  }

  static RecipeDetailsModel deepCopy(RecipeDetailsModel model) {
    return RecipeDetailsModel(
        preparationTime: model.preparationTime,
        cookingTime: model.cookingTime,
        serves: model.serves);
  }
}
