import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/recipe_ingredient_model.dart';
import '../models/recipe_model.dart';
import '../models/user_data_model.dart';
import '../services/recipe_services.dart';
import 'app_cubit_states.dart';

import 'package:http/http.dart' as http;

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
  // Gets the authentication request state or error state
  void getInitialData() async {
    try {
      emit(AuthenticationRequestState());
    } catch (e) {
      emit(ErrorState());
    }
  }

  // Authentication page
  // Authenticates the user and returns, gets the data linked to the user and
  // then, the authenticated state or error state
  void retrieveUserData() async {
    userData = UserDataModel(
        id: await FirebaseAuth.instance.currentUser!.getIdToken(),
        recipes: await RecipeServices().getRecipes());

    emit(AuthenticatedState(userData.recipes, [...userData.recipes],
        recipeIngredients, [...recipeIngredients]));
  }

  // Creates an account, then go to the login page if successful
  Future<bool> register(email, password) async {
    try {
      emit(AuthenticationRequestState());
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
      recipe.id = res.headers['location']!
          .substring(res.headers['location']!.lastIndexOf('/') + 1);
      userData.recipes.add(recipe);
      return res;
    } else {
      emit(ErrorState());
    }
  }

  deleteRecipe(RecipeModel recipe) async {
    http.Response res = await recipeServices.deleteRecipe(recipe);
    if (res.statusCode == 204) {
      userData.recipes.removeWhere((recipe2) => recipe2.id == recipe.id);
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

  // To recipes
  void gotoRecipes() async {
    try {
      emit(AuthenticatedState(userData.recipes, [...userData.recipes],
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
      emit(AuthenticatedState(userData.recipes, [...userData.recipes],
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
