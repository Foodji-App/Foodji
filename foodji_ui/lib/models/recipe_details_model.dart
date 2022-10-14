// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:faker/faker.dart';

class RecipeDetailsModel {
  int? cookingTime;
  int? preparationTime;
  int? restingTime;
  int? serves;
  int? totalTime;

  RecipeDetailsModel(
      {required this.cookingTime,
      required this.preparationTime,
      required this.restingTime,
      required this.serves,
      required this.totalTime});

  factory RecipeDetailsModel.fromJson(Map<String, dynamic> json) {
    return RecipeDetailsModel(
        cookingTime: json['cookingTime'],
        preparationTime: json['preparationTime'],
        restingTime: json['restingTime'],
        serves: json['serves'],
        totalTime: json['totalTime']);
  }

  toText() =>
      'cookingTime: ${cookingTime.toString()}\n' +
      'preparationTime: ${preparationTime.toString()}\n' +
      'restingTime: ${restingTime.toString()}\n' +
      'serves: ${serves.toString()}\n' +
      'totalTime: ${totalTime.toString()}\n';

  static RecipeDetailsModel getSample() {
    var faker = Faker();
    var cookingTime = faker.guid.random.integer(120);
    var preparationTime = faker.guid.random.integer(30);
    var restingTime = faker.guid.random.integer(30);
    var serves = faker.guid.random.integer(10);
    var totalTime = cookingTime + preparationTime + restingTime;
    return RecipeDetailsModel(
        cookingTime: cookingTime,
        preparationTime: preparationTime,
        restingTime: restingTime,
        serves: serves,
        totalTime: totalTime);
  }

  static List<RecipeDetailsModel> getSamples(int amount) {
    var samples = <RecipeDetailsModel>[];

    for (var i = 0; i < amount; i++) {
      samples.add(getSample());
    }
    return samples;
  }

  static RecipeDetailsModel deepCopy(RecipeDetailsModel model) {
    return RecipeDetailsModel(
        cookingTime: model.cookingTime,
        preparationTime: model.preparationTime,
        restingTime: model.restingTime,
        serves: model.serves,
        totalTime: model.totalTime);
  }

  bool equals(RecipeDetailsModel other) {
    return cookingTime == other.cookingTime &&
        preparationTime == other.preparationTime &&
        restingTime == other.restingTime &&
        serves == other.serves &&
        totalTime == other.totalTime;
  }
}
