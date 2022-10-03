import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/navigation_bar.dart' as navigation_bar_widget;
import '../pages/authentification_page.dart';
import '../pages/exploration_page.dart';
import '../pages/favorites_page.dart';
import '../pages/profile_page.dart';
import '../pages/recipes_page.dart';
import '../pages/error_page.dart';
import '../pages/tools_page.dart';
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
      } else if (state is RecipesState) {
        return const RecipesPage();
      } else if (state is ExplorationState) {
        return const ExplorationPage();
      } else if (state is FavoritesState) {
        return const FavoritesPage();
      } else if (state is ProfileState) {
        return const ProfilePage();
      } else if (state is ToolsState) {
        return const ToolsPage();
      } else if (state is ErrorState) {
        return const ErrorPage();
      } else {
        return Container();
      }
    }));
  }
}
