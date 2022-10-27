import 'package:faker/faker.dart';
import 'package:foodji_ui/models/unit_type_enum.dart';

class MeasurementModel {
  String alternativeText;
  String unitType;
  num value; // Must be a num, which is parent to double and int, as received data can be interpreted as either by json convert

  MeasurementModel(
      {required this.alternativeText,
      required this.unitType,
      required this.value});

  factory MeasurementModel.fromJson(Map<String, dynamic> json) {
    return MeasurementModel(
        alternativeText: json['alternativeText'],
        value: json['value'],
        unitType: json['unitType']);
  }

  static MeasurementModel getSample() {
    var faker = Faker();

    return MeasurementModel(
        alternativeText: faker.food.cuisine(),
        value: faker.randomGenerator.decimal(),
        unitType: faker.randomGenerator.element(UnitType.values).name);
  }

  static List<MeasurementModel> getSamples(int amount) {
    var samples = <MeasurementModel>[];

    for (var i = 0; i < amount; i++) {
      samples.add(getSample());
    }
    return samples;
  }
}