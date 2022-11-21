import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/recipe_ingredient_model.dart';
import '../models/recipe_model.dart';
import '../models/user_data_model.dart';
import '../services/login_services.dart';
import '../services/recipe_services.dart';
import 'app_cubit_states.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.loginServices, required this.recipeServices})
      : super(InitialState()) {
    emit(InitState());
  }

  final RecipeServices recipeServices;
  final LoginServices loginServices;

  // Data ----------------------------------------

  // User
  late UserDataModel userData;

  // Ingredients
  List<RecipeIngredientModel> recipeIngredients = [];

  // Getters -------------------------------------

  // Splash page
  // Gets any data that is not linked to the user and then, the authentification
  // request state or error state
  void getInitialData() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        retrieveUserData();
      } else {
        emit(AuthentificationRequestState());
      }
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

    //userData.recipes.addAll(RecipeModel.getSamples(20));
    recipeIngredients.addAll(RecipeIngredientModel.getSamples(20));

    emit(AuthentifiedState(userData.recipes, [...userData.recipes],
        recipeIngredients, [...recipeIngredients]));
  }

  // Creates an account, then go to the login page if successful
  //TODO - Complete the registration process
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
    getInitialData();

    RecipeModel targetRecipe =
        userData.recipes.firstWhere((element) => element.id == recipe.id);
    targetRecipe.isFavorite = !targetRecipe.isFavorite;
    return targetRecipe;
  }

  updateRecipe(recipe) {
    getInitialData();

    RecipeModel targetRecipe =
        userData.recipes.firstWhere((element) => element.id == recipe.id);
    targetRecipe = recipe;
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
    getInitialData();
    try {
      emit(AuthentifiedState(userData.recipes, [...userData.recipes],
          recipeIngredients, [...recipeIngredients]));
    } catch (e) {
      emit(ErrorState());
    }
  }

  // To recipe details
  void gotoRecipeDetails(recipe) async {
    getInitialData();
    try {
      emit(RecipeState(recipe));
    } catch (e) {
      emit(ErrorState());
    }
  }

  void gotoRecipeEditor(recipe) async {
    getInitialData();
    try {
      emit(RecipeEditorState(recipe));
    } catch (e) {
      emit(ErrorState());
    }
  }

  // To ingredients
  void gotoIngredients() async {
    getInitialData();
    try {
      emit(AuthentifiedState(userData.recipes, [...userData.recipes],
          recipeIngredients, [...recipeIngredients]));
    } catch (e) {
      emit(ErrorState());
    }
  }

  // To recipe details
  void gotoIngredientDetails(recipe) async {
    getInitialData();
    try {
      emit(IngredientState(recipe));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
