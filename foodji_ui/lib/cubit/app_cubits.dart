import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/ingredient_model.dart';
import '../models/recipe_model.dart';
import '../services/data_services.dart';
import 'app_cubit_states.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data}) : super(InitialState()) {
    emit(InitState());
  }

  final DataServices data;

  // Data ----------------------------------------

  // Recipes
  List<RecipeModel> recipes = [];

  // Ingredients
  List<IngredientModel> ingredients = [];

  // Getters -------------------------------------

  // Splash page
  // Gets any data that is not linked to the user and then, the authentification
  // request state or error state
  void getInitialData() async {
    try {
      emit(AuthentificationRequestState());
    } catch (e) {
      emit(ErrorState());
    }
  }

  // Authentification page
  // Authentifies the user and returns, gets the data linked to the user and
  // then, the authentified state or error state
  void authentify() async {
    try {
      recipes.addAll(RecipeModel.getSamples(20));
      ingredients.addAll(IngredientModel.getSamples(20));
      emit(AuthentifiedState(
          recipes, [...recipes], ingredients, [...ingredients])); //Deep copy
    } catch (e) {
      emit(ErrorState());
    }
  }

  // Setters -------------------------------------

  toggleFavoriteStatus(recipe) {
    RecipeModel targetRecipe =
        recipes.firstWhere((element) => element.id == recipe.id);
    targetRecipe.isFavorite = !targetRecipe.isFavorite;
    return targetRecipe;
  }

  // Navigation ----------------------------------

  // To splash screen
  void gotoInit() async {
    try {
      emit(InitState());
    } catch (e) {
      emit(ErrorState());
    }
  }

  // To recipes
  void gotoRecipes() async {
    try {
      emit(AuthentifiedState(
          recipes, [...recipes], ingredients, [...ingredients]));
    } catch (e) {
      emit(ErrorState());
    }
  }

  // To recipe details
  void gotoRecipeDetails(recipe) async {
    try {
      emit(RecipeState(recipe));
    } catch (e) {
      emit(ErrorState());
    }
  }

  // To ingredients
  void gotoIngredients() async {
    try {
      emit(AuthentifiedState(
          recipes, [...recipes], ingredients, [...ingredients]));
    } catch (e) {
      emit(ErrorState());
    }
  }

  // To recipe details
  void gotoIngredientDetails(recipe) async {
    try {
      emit(IngredientState(recipe));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
