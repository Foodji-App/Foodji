// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) => RecipeModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      imageUri: json['imageUri'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      details:
          RecipeDetailsModel.fromJson(json['details'] as Map<String, dynamic>),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => RecipeIngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
      isFavorite: json['isFavorite'] as bool,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$RecipeModelToJson(RecipeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUri': instance.imageUri,
      'category': instance.category,
      'description': instance.description,
      'details': instance.details,
      'ingredients': instance.ingredients,
      'steps': instance.steps,
      'createdAt': instance.createdAt?.toIso8601String(),
      'isFavorite': instance.isFavorite,
    };
