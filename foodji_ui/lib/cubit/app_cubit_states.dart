import 'package:equatable/equatable.dart';
import 'package:foodji_ui/models/recipe_model.dart';

import '../models/recipe_ingredient_model.dart';

abstract class CubitStates extends Equatable {}

// Default state when starting the app
class InitialState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

// When actively loading the informations needed throughout the app,
// displays a splash screen
class InitState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

// When actively loading an information needed at a certain moment,
// displays a circular loading pattern
class LoadingState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

// After splash screen, when loading is complete, display an authorization
// request screen
class AuthentificationRequestState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

// Once authorized, displays the user's recipes list as the main page
class AuthentifiedState extends CubitStates {
  AuthentifiedState(this.recipes, this.filteredRecipes, this.ingredients,
      this.filteredIngredients);
  final List<RecipeModel> recipes;
  final List<RecipeModel> filteredRecipes;
  final List<RecipeIngredientModel> ingredients;
  final List<RecipeIngredientModel> filteredIngredients;
  @override
  List<Object> get props => throw [recipes, filteredRecipes];
}

// When a recipe is selected, displays the recipe details
class RecipeState extends CubitStates {
  RecipeState(this.recipe);
  final RecipeModel recipe;
  @override
  List<Object> get props => throw [recipe];
}

class RecipeEditorState extends CubitStates {
  RecipeEditorState(this.recipe);
  final RecipeModel recipe;
  @override
  List<Object> get props => throw [recipe];
}

// When an ingredient is selected, displays the ingredient details
class IngredientState extends CubitStates {
  IngredientState(this.ingredient);
  final RecipeIngredientModel ingredient;
  @override
  List<Object> get props => throw [ingredient];
}

// If any error occurs, redirect to this page that displays the error message,
// and offers to reload the app from the splash screen
class ErrorState extends CubitStates {
  @override
  List<Object> get props => throw [];
}
