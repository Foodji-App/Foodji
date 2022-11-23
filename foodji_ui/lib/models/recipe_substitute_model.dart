import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:foodji_ui/models/tags_enum.dart';

import 'measurement_model.dart';

class RecipeSubstituteModel {
  String? id;
  String name;
  String? substitutionPrecisions;
  String? description;
  MeasurementModel measurement;
  List<String> tags;

  RecipeSubstituteModel(
      {required this.id,
      required this.name,
      required this.substitutionPrecisions,
      required this.description,
      required this.measurement,
      required this.tags});

  factory RecipeSubstituteModel.fromJson(Map<String, dynamic> json) {
    return RecipeSubstituteModel(
        id: json['id'],
        name: json['name'],
        substitutionPrecisions: json['substitutionPrecisions'],
        description: json['description'],
        measurement: MeasurementModel.fromJson(json['measurement']),
        tags: json['tags'].cast<String>());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'substitutionPrecisions': substitutionPrecisions,
      'description': description,
      'measurement': jsonEncode(measurement),
      'tags': tags.map((t) => jsonEncode(t)).toList()
    };
  }

  static RecipeSubstituteModel getSample() {
    var faker = Faker();

    return RecipeSubstituteModel(
        id: faker.guid.random.string(16), // Not Fail Safe
        name: faker.food.cuisine(),
        substitutionPrecisions:
            faker.lorem.sentences(random.integer(1, min: 0)).join(' '),
        description: faker.lorem.sentences(random.integer(2, min: 1)).join(' '),
        measurement: MeasurementModel.getSamples(1)[0],
        tags: {
          faker.randomGenerator.element(Tags.values).name,
          faker.randomGenerator.element(Tags.values).name
        }.toList());
  }

  static List<RecipeSubstituteModel> getSamples(int amount) {
    var samples = <RecipeSubstituteModel>[];

    for (var i = 0; i < amount; i++) {
      samples.add(getSample());
    }
    return samples;
  }

  static deepCopy(List<RecipeSubstituteModel> ingredients) {
    var copy = <RecipeSubstituteModel>[];

    for (var ingredient in ingredients) {
      copy.add(RecipeSubstituteModel(
          id: ingredient.id,
          name: ingredient.name,
          substitutionPrecisions: ingredient.substitutionPrecisions,
          description: ingredient.description,
          measurement: ingredient.measurement,
          tags: ingredient.tags));
    }
    return copy;
  }

  bool equals(RecipeSubstituteModel other) {
    return id == other.id &&
        name == other.name &&
        substitutionPrecisions == other.substitutionPrecisions &&
        description == other.description &&
        measurement.equals(other.measurement) &&
        tags == other.tags;
  }
}
