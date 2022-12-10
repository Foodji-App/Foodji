// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeasurementModel _$MeasurementModelFromJson(Map<String, dynamic> json) =>
    MeasurementModel(
      alternativeText: json['alternativeText'] as String,
      unitType: json['unitType'] as String,
      value: json['value'] as num,
    );

Map<String, dynamic> _$MeasurementModelToJson(MeasurementModel instance) =>
    <String, dynamic>{
      'alternativeText': instance.alternativeText,
      'unitType': instance.unitType,
      'value': instance.value,
    };
