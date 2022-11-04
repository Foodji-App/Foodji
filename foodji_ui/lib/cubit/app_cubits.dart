import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/recipe_ingredient_model.dart';
import '../models/recipe_model.dart';
import '../services/recipe_services.dart';
import 'app_cubit_states.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.recipeServices}) : super(InitialState()) {
    emit(InitState());
  }

  final RecipeServices recipeServices;

  // Data ----------------------------------------

  // Recipes
  late List<RecipeModel> recipes = [];

  // Ingredients
  List<RecipeIngredientModel> recipeIngredients = [];

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
      //recipes = await recipeServices.getRecipes();
      recipeIngredients.addAll(RecipeIngredientModel.getSamples(20));
      emit(AuthentifiedState(recipes, [...recipes], recipeIngredients,
          [...recipeIngredients])); //Deep copy
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
          recipes, [...recipes], recipeIngredients, [...recipeIngredients]));
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
          recipes, [...recipes], recipeIngredients, [...recipeIngredients]));
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
