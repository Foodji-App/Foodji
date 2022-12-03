// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_substitute_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeSubstituteModel _$RecipeSubstituteModelFromJson(
        Map<String, dynamic> json) =>
    RecipeSubstituteModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      substitutionPrecision: json['substitutionPrecision'] as String?,
      description: json['description'] as String?,
      measurement: MeasurementModel.fromJson(
          json['measurement'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RecipeSubstituteModelToJson(
        RecipeSubstituteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'substitutionPrecision': instance.substitutionPrecision,
      'description': instance.description,
      'measurement': instance.measurement,
      'tags': instance.tags,
    };
