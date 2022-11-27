import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/recipe_ingredient_model.dart';
import '../models/recipe_model.dart';
import '../models/user_data_model.dart';
import '../services/recipe_services.dart';
import 'app_cubit_states.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.recipeServices}) : super(InitialState()) {
    emit(InitState());
  }

  final RecipeServices recipeServices;

  // Data ----------------------------------------

  // User
  late UserDataModel userData;

  // Ingredients
  List<RecipeIngredientModel> recipeIngredients = [];

  // Getters -------------------------------------

  // Splash page
  // Gets the authentification request state or error state
  void getInitialData() async {
    try {
      emit(AuthentificationRequestState());
    } catch (e) {
      emit(ErrorState());
    }
  }

  // Authentication page
  // Authentifies the user and returns, gets the data linked to the user and
  // then, the authentified state or error state
  void retrieveUserData() async {
    userData = UserDataModel(
        id: await FirebaseAuth.instance.currentUser!.getIdToken(),
        recipes: await RecipeServices().getRecipes());

    recipeIngredients.addAll(RecipeIngredientModel.getSamples(20));

    emit(AuthentifiedState(userData.recipes, [...userData.recipes],
        recipeIngredients, [...recipeIngredients]));
  }

  // Creates an account, then go to the login page if successful
  //TODO - Compléter le processus de création de compte
  Future<bool> register(email, password) async {
    try {
      emit(AuthentificationRequestState());
      return true;
    } catch (e) {
      emit(ErrorState());
    }
    return false;
  }

  // Setters -------------------------------------

  toggleFavoriteStatus(recipe) {
    RecipeModel targetRecipe =
        userData.recipes.firstWhere((element) => element.id == recipe.id);
    targetRecipe.isFavorite = !targetRecipe.isFavorite;
    return targetRecipe;
  }

  updateRecipe(RecipeModel recipe) async {
    http.Response res = await recipeServices.updateRecipe(recipe);
    if (res.statusCode == 201) {
      userData.recipes[userData.recipes.indexWhere((r) => r.id == recipe.id)] =
          recipe;
      return res;
    } else {
      emit(ErrorState());
    }
  }

  createRecipe(RecipeModel recipe) async {
    http.Response res = await recipeServices.createRecipe(recipe);
    if (res.statusCode == 201) {
      recipe.id = json.decode(res.body)[
          'id']; //TODO - Valider le retour de fonction et le stockage de l'id dans la recette
      userData.recipes.add(recipe);
      return res;
    } else {
      emit(ErrorState());
    }
  }

  deleteRecipe(RecipeModel recipe) async {
    http.Response res = await recipeServices.deleteRecipe(recipe.id.toString());
    if (res.statusCode == 204) {
      userData.recipes.removeWhere(
          (recipe) => recipe.id.toString() == recipe.id.toString());
      return res;
    } else {
      emit(ErrorState());
    }
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

  // To registration screen
  void gotoRegistration() async {
    try {
      emit(RegistrationState());
    } catch (e) {
      emit(ErrorState());
    }
  }

  // To recipes
  void gotoRecipes() async {
    try {
      emit(AuthentifiedState(userData.recipes, [...userData.recipes],
          recipeIngredients, [...recipeIngredients]));
    } catch (e) {
      emit(ErrorState());
    }
  }

  // To add recipe
  void gotoAddRecipe() async {
    try {
      emit(RecipeEditorState(RecipeModel.newRecipeModel()));
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

  void gotoRecipeEditor(recipe) async {
    try {
      emit(RecipeEditorState(recipe));
    } catch (e) {
      emit(ErrorState());
    }
  }

  // To ingredients
  void gotoIngredients() async {
    try {
      emit(AuthentifiedState(userData.recipes, [...userData.recipes],
          recipeIngredients, [...recipeIngredients]));
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
