import 'package:faker/faker.dart';

import 'ingredient_model.dart';

class RecipeModel {
  String name;
  String img;
  String category; // tags
  String desc;
  RecipeDetailsModel details;
  List<IngredientModel> ingredients;
  List<String> steps;
  DateTime createdAt;

  RecipeModel({
    required this.name,
    required this.img,
    required this.category,
    required this.desc,
    required this.details,
    required this.ingredients,
    required this.steps,
    required this.createdAt,
  });

  // TODO when recieved from server
  //factory RecipeModel.fromJson(Map<String, dynamic> json) {
  //   return RecipeModel();
  // }

  static RecipeModel getSample() {
    var faker = Faker();

    return RecipeModel(
      name: faker.food.dish(),
      img: "https://picsum.photos/200/300",
      category: faker.food.cuisine(),
      desc: faker.lorem.sentence(),
      details: RecipeDetailsModel.getSample(),
      ingredients: IngredientModel.getSamples(random.integer(10, min: 3)),
      steps: faker.lorem.sentences(random.integer(10, min: 3)),
      createdAt: faker.date.dateTime(),
    );
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

  static RecipeDetailsModel getSample() {

    return RecipeDetailsModel(
        prepTime: random.integer(90, min: 15),
        cookTime: random.integer(270, min: 15),
        serves: random.integer(8, min: 1));
  }
}