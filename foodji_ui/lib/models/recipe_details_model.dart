// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:faker/faker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe_details_model.g.dart';

@JsonSerializable()
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

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory RecipeDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailsModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RecipeDetailsModelToJson(this);

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

  static newRecipeDetailsModel() {
    return RecipeDetailsModel(
        cookingTime: 0,
        preparationTime: 0,
        restingTime: 0,
        totalTime: 0,
        serves: null);
  }
}
