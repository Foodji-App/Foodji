// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'dart:math';

import 'package:faker/faker.dart';

import 'ingredient_model.dart';

class RecipeModel {
  int id;
  String name;
  String img;
  String category; // tags
  String description;
  RecipeDetailsModel details;
  List<IngredientModel> ingredients;
  List<String> steps;
  DateTime createdAt;
  bool isFavorite;

  RecipeModel(
      {required this.id,
      required this.name,
      required this.img,
      required this.category,
      required this.description,
      required this.details,
      required this.ingredients,
      required this.steps,
      required this.createdAt,
      required this.isFavorite});

  // TODO when recieved from server
  //factory RecipeModel.fromJson(Map<String, dynamic> json) {
  //   return RecipeModel();
  // }

  toText() =>
      'id: ${id.toString()}\n' +
      'createdAt: $createdAt\n' +
      'name: $name\n' +
      'img: $img\n' +
      'category: $category\n' +
      'desc: $description\n' +
      'details: ${details.toText()}\n' +
      'isFavorite: ${isFavorite.toString()}' +
      'ingredients: \n - ${ingredients.join('\n - ')}\n\n' +
      'steps: \n - ${steps.join('\n - ')}\n';

  static RecipeModel newRecipeModel() {
    return RecipeModel(
        id: 0,
        name: '',
        img: '',
        category: '',
        description: '',
        details: RecipeDetailsModel.newRecipeModel(),
        ingredients: [],
        steps: [],
        createdAt: DateTime.now(),
        isFavorite: false);
  }

  static RecipeModel getSample() {
    var faker = Faker();

    return RecipeModel(
        id: faker.guid.random.integer(99999999), // Not Fail Safe
        name: faker.food.dish(),
        img: "https://picsum.photos/seed/${faker.food.dish()}/500/300",
        category: faker.food.cuisine(),
        description: faker.lorem.sentences(random.integer(4, min: 1)).join(' '),
        details: RecipeDetailsModel.getSample(),
        ingredients: IngredientModel.getSamples(random.integer(10, min: 3)),
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

class RecipeDetailsModel {
  int prepTime;
  int cookTime;
  int serves;

  int get totalTime => prepTime + cookTime;

  RecipeDetailsModel({
    required this.prepTime,
    required this.cookTime,
    required this.serves,
  });

  toText() => 'prepTime: $prepTime\ncookTime: $cookTime\nserves: $serves\n';

  static RecipeDetailsModel newRecipeModel() {
    return RecipeDetailsModel(
      prepTime: 0,
      cookTime: 0,
      serves: 0,
    );
  }

  static RecipeDetailsModel getSample() {
    return RecipeDetailsModel(
        prepTime: random.integer(90, min: 15),
        cookTime: random.integer(270, min: 15),
        serves: random.integer(8, min: 1));
  }
}
