// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeDetailsModel _$RecipeDetailsModelFromJson(Map<String, dynamic> json) =>
    RecipeDetailsModel(
      cookingTime: json['cookingTime'] as int?,
      preparationTime: json['preparationTime'] as int?,
      restingTime: json['restingTime'] as int?,
      serves: json['serves'] as int?,
      totalTime: json['totalTime'] as int?,
    );

Map<String, dynamic> _$RecipeDetailsModelToJson(RecipeDetailsModel instance) =>
    <String, dynamic>{
      'cookingTime': instance.cookingTime,
      'preparationTime': instance.preparationTime,
      'restingTime': instance.restingTime,
      'serves': instance.serves,
      'totalTime': instance.totalTime,
    };
