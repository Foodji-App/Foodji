import 'package:equatable/equatable.dart';

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
  @override
  List<Object> get props => throw [];
}

// When the menu is selected, displays the user's recipes list
class RecipesState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

// When the menu is selected, displays the exploration page where the user's
// favorite recipes from his or others are displayed
class ExplorationState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

// When the menu is selected, displays the favorites page where favorite recipes
// from other users are displayed
class FavoritesState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

// When the menu is selected, displays the user's profile and the parameters
// that can be adjusted
class ProfileState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

// When the speed dial menu is selected, displays the converter tool
class ConverterState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

// When the speed dial menu is selected, displays the ingredients tool
class IngredientsState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

// When the speed dial menu is selected, displays the pantry tool
class PantryState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

// When the speed dial menu is selected, displays the grocery tool
class GroceryState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

// If any error occurs, redirect to this page that displays the error message,
// and offers to reload the app from the splash screen
class ErrorState extends CubitStates {
  @override
  List<Object> get props => throw [];
}
