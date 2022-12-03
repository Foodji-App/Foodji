import 'package:faker/faker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:foodji_ui/models/tags_enum.dart';

import 'measurement_model.dart';
part 'recipe_substitute_model.g.dart';

@JsonSerializable()
class RecipeSubstituteModel {
  String? id;
  String name;
  String? substitutionPrecision;
  String? description;
  MeasurementModel measurement;
  List<String> tags;

  RecipeSubstituteModel(
      {required this.id,
      required this.name,
      required this.substitutionPrecision,
      required this.description,
      required this.measurement,
      required this.tags});

  /// Connect the generated [_$RecipeSubstituteModelFromJson] function to the `fromJson`
  /// factory.
  factory RecipeSubstituteModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeSubstituteModelFromJson(json);

  /// Connect the generated [_$RecipeSubstituteModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RecipeSubstituteModelToJson(this);

  static RecipeSubstituteModel getSample() {
    var faker = Faker();

    return RecipeSubstituteModel(
        id: faker.guid.random.string(16), // Not Fail Safe
        name: faker.food.cuisine(),
        substitutionPrecision:
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
          substitutionPrecision: ingredient.substitutionPrecision,
          description: ingredient.description,
          measurement: ingredient.measurement,
          tags: ingredient.tags));
    }
    return copy;
  }

  bool equals(RecipeSubstituteModel other) {
    return id == other.id &&
        name == other.name &&
        substitutionPrecision == other.substitutionPrecision &&
        description == other.description &&
        measurement.equals(other.measurement) &&
        tags == other.tags;
  }
}
