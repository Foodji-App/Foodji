// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_ingredient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeIngredientModel _$RecipeIngredientModelFromJson(
        Map<String, dynamic> json) =>
    RecipeIngredientModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      measurement: MeasurementModel.fromJson(
          json['measurement'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      substitutes: (json['substitutes'] as List<dynamic>)
          .map((e) => RecipeSubstituteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecipeIngredientModelToJson(
        RecipeIngredientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'measurement': instance.measurement,
      'tags': instance.tags,
      'substitutes': instance.substitutes,
    };
