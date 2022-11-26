import 'package:faker/faker.dart';
import 'package:foodji_ui/models/unit_type_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'measurement_model.g.dart';

@JsonSerializable()
class MeasurementModel {
  String alternativeText;
  String unitType;
  num value; // Must be a num, which is parent to double and int, as received data can be interpreted as either by json convert

  MeasurementModel(
      {required this.alternativeText,
      required this.unitType,
      required this.value});

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory MeasurementModel.fromJson(Map<String, dynamic> json) =>
      _$MeasurementModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MeasurementModelToJson(this);

  // factory MeasurementModel.fromJson(Map<String, dynamic> json) {
  //   return MeasurementModel(
  //       alternativeText: json['alternativeText'],
  //       value: json['value'],
  //       unitType: json['unitType']);
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'alternativeText': alternativeText,
  //     'value': value.toString(),
  //     'unitType': unitType
  //   };
  // }

  static MeasurementModel getSample() {
    var faker = Faker();

    return MeasurementModel(
        alternativeText: faker.food.cuisine(),
        value: faker.randomGenerator.decimal(scale: 4, min: 0),
        unitType: faker.randomGenerator.element(UnitType.values).name);
  }

  static List<MeasurementModel> getSamples(int amount) {
    var samples = <MeasurementModel>[];

    for (var i = 0; i < amount; i++) {
      samples.add(getSample());
    }
    return samples;
  }

  static MeasurementModel deepCopy(MeasurementModel measurement) {
    return MeasurementModel(
        alternativeText: measurement.alternativeText,
        value: measurement.value,
        unitType: measurement.unitType);
  }

  bool equals(MeasurementModel measurement) {
    return alternativeText == measurement.alternativeText &&
        unitType == measurement.unitType &&
        value == measurement.value;
  }
}
