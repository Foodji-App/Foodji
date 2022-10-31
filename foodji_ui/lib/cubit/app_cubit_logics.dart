import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/pages/recipe_editor_page.dart';

import '../pages/ingredient_detail_page.dart';
import '../pages/recipe_detail_page.dart';
import '../widgets/navigation_bar.dart' as navigation_bar_widget;
import '../pages/authentification_page.dart';
import '../pages/error_page.dart';
import 'app_cubit_states.dart';
import 'app_cubits.dart';

import '../pages/splash_page.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({super.key});

  @override
  State<AppCubitLogics> createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      if (state is InitState) {
        return const SplashPage();
      } else if (state is LoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is AuthentificationRequestState) {
        return const AuthentificationPage();
      } else if (state is AuthentifiedState) {
        return const navigation_bar_widget.NavigationBar();
      } else if (state is RecipeState) {
        return const RecipeDetailPage();
      } else if (state is RecipeEditorState) {
        return const RecipeEditorPage();
      } else if (state is IngredientState) {
        return const IngredientDetailPage();
      } else if (state is ErrorState) {
        return const ErrorPage();
      } else {
        return Container();
      }
    }));
  }
}
