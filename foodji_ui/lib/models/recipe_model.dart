import 'package:faker/faker.dart';
import 'package:foodji_ui/models/recipe_details_model.dart';

import 'ingredient_model.dart';

class RecipeModel {
  String id;
  String name;
  String img;
  String category; // tags
  // bool isFavorite;
  String desc;
  RecipeDetails details;
  List<IngredientModel> ingredients;
  List<String> steps;
  // String createdBy;
  DateTime createdAt;

  RecipeModel({
    required this.id,
    required this.name,
    required this.img,
    required this.category,
    // required this.isFavorite,
    required this.desc,
    required this.details,
    required this.ingredients,
    required this.steps,
    // required this.createdBy,
    required this.createdAt,
  });

  // TODO when recieved from server
  //factory RecipeModel.fromJson(Map<String, dynamic> json) {
  //   return RecipeModel();
  // }

  static RecipeModel getSample() {
    var faker = Faker();

    return RecipeModel(
      id: faker.guid.toString(),
      name: faker.food.dish(),
      img: "https://picsum.photos/200/300",
      category: faker.food.cuisine(),
      // isFavorite: faker.randomGenerator.boolean(),
      desc: faker.food.cuisine(),
      details: RecipeDetails(
        serves: faker.randomGenerator.integer(6),
      ),
      ingredients: [],
      steps: _tgif,
      // createdBy: _who(),
      createdAt: faker.date.dateTime(),
    );
  }

  static final List<String> _tgif = [
    "Step by step, ooh, baby\nGonna get to you, girl\nStep by step, rah\n",
    "Step by step, ooh, baby\nGonna get to you, girl\nStep by step, ooh, baby\nReally want you in my world\n",
    "hey girl, in your eyes\nI see a picture of me all the time\n(Step) and girl, when you smile\nYou got to know that you drive me wild\n",
    "ooh, baby\nYou're always on my mind\n(Step by step) ooh, girl\nI really think it's just the matter of time\n",
    "Step by step, ooh, baby\nGonna get to you, girl\nStep by step, ooh, baby\nReally want you in my world\n",
    "hey girl, can't you see?\nI've got to have you all, just for me\n(Step) and girl, yes, it's true\nNo one else will ever do\n",
    "ooh, baby\nYou're always on my mind\n(Step by step) ooh, girl\nI really think it's just the matter of time\n",
    "Step by step, ooh, baby\nGonna get to you, girl\nStep by step, ooh, baby\nReally want you in my world\n",
    "Step\nStep\nStep\nStep by step\n",
    "we can have lots of fun\n(Step two) there's so much we can do\n(Step three) it's just you and me\n(Step four) I can give you more\n(Step five) don't you know that the time has arrived?\nHuh!\n",
    "Step by step\nDon't you know I need you?\nStep by step\nYes, I do girl\n",
    "ooh, baby\nYou're always on my mind\n(Step by step) ooh, girl\nI really think it's just the matter of time\n",
    "Step by step (step by step, girl), ooh, baby\nGonna get to you, girl (to you, girl)\nStep by step (yeah, ooh, baby, I want you, I need you)\nReally want you in my world (I want you in my world)\n",
    "Step by step (ooh, ooh-ooh)\nTo you, girl (ooh, hoo, hoo, ooh)\nStep by step, oh, girl\nReally want you in my world",
    "Step by step, ooh, baby\nGonna get to you, girl\nStep by step, ooh baby"
  ];
}
