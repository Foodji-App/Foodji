import 'package:flutter_bloc/flutter_bloc.dart';

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

  // Getters -------------------------------------

  // Splash page
  void getInitialData() async {
    try {
      emit(AuthentificationRequestState());
    } catch (e) {
      emit(ErrorState());
    }
  }

  // Authentification page
  void authentify() async {
    try {
      for (var i = 0; i < 10; i++) {
        recipes.add(RecipeModel.getSample());
      }
      emit(AuthentifiedState(recipes, [...recipes])); //Deep copy
    } catch (e) {
      emit(ErrorState());
    }
  }

  // Setters -------------------------------------

  // Navigation ----------------------------------

  // To splash screen
  void gotoInit() async {
    try {
      emit(InitState());
    } catch (e) {
      emit(ErrorState());
    }
  }
}
