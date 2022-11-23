import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:foodji_ui/models/tags_enum.dart';
import 'package:foodji_ui/models/recipe_substitute_model.dart';

import 'measurement_model.dart';

class RecipeIngredientModel {
  String? id;
  String name;
  String? description;
  MeasurementModel measurement;
  List<String> tags;
  List<RecipeSubstituteModel> substitutes;

  RecipeIngredientModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.measurement,
      required this.tags,
      required this.substitutes});

  factory RecipeIngredientModel.fromJson(Map<String, dynamic> json) {
    return RecipeIngredientModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        measurement: MeasurementModel.fromJson(json['measurement']),
        substitutes: json['substitutes']
            .map<RecipeSubstituteModel>(
                (e) => RecipeSubstituteModel.fromJson(e))
            .toList(),
        tags: json['tags'].cast<String>());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'measurement': jsonEncode(measurement),
      'substitutes': substitutes.map((s) => jsonEncode(s)).toList(),
      'tags': tags.map((t) => jsonEncode(t)).toList()
    };
  }

  static RecipeIngredientModel getSample() {
    var faker = Faker();

    return RecipeIngredientModel(
        id: faker.guid.random.string(16), // Not Fail Safe
        name: faker.food.cuisine(),
        description: faker.lorem.sentences(random.integer(2, min: 1)).join(' '),
        measurement: MeasurementModel.getSamples(1)[0],
        tags: {
          faker.randomGenerator.element(Tags.values).name,
          faker.randomGenerator.element(Tags.values).name
        }.toList(),
        substitutes:
            RecipeSubstituteModel.getSamples(random.integer(2, min: 0)));
  }

  static List<RecipeIngredientModel> getSamples(int amount) {
    var samples = <RecipeIngredientModel>[];

    for (var i = 0; i < amount; i++) {
      samples.add(getSample());
    }
    return samples;
  }

  static RecipeIngredientModel newRecipeIngredientModel() {
    return RecipeIngredientModel(
        id: null,
        name: '',
        description: '',
        measurement: MeasurementModel.getSamples(1)[0],
        tags: [],
        substitutes: []);
  }

  static deepCopy(List<RecipeIngredientModel> ingredients) {
    var copy = <RecipeIngredientModel>[];

    for (var ingredient in ingredients) {
      copy.add(RecipeIngredientModel(
          id: ingredient.id,
          name: ingredient.name,
          description: ingredient.description,
          measurement: ingredient.measurement,
          tags: ingredient.tags,
          substitutes: RecipeSubstituteModel.deepCopy(ingredient.substitutes)));
    }
    return copy;
  }

  bool equals(RecipeIngredientModel other) {
    return id == other.id &&
        name == other.name &&
        description == other.description &&
        measurement.equals(other.measurement) &&
        tags == other.tags &&
        _equalsSubstitutes(other.substitutes);
  }

  bool _equalsSubstitutes(List<RecipeSubstituteModel> otherSubstitutes) {
    if (substitutes.length != otherSubstitutes.length) {
      return false;
    }

    for (var i = 0; i < substitutes.length; i++) {
      if (!substitutes[i].equals(otherSubstitutes[i])) {
        return false;
      }
    }
    return true;
  }
}
