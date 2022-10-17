import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodji_ui/models/recipe_model.dart';

import '../cubit/app_globals.dart' as globals;
import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../misc/colors.dart';
import '../widgets/app_text.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({Key? key}) : super(key: key);

  @override
  RecipesPageState createState() => RecipesPageState();
}

class RecipesPageState extends State<RecipesPage> {
  TextEditingController searchBoxController = TextEditingController();
  // Class member to be updatable by setState
  String filterQuery = "";
  bool favoritesOnly = false;

  toggleFavoriteStatus(recipe) {
    setState(() {
      try {
        recipe =
            BlocProvider.of<AppCubits>(context).toggleFavoriteStatus(recipe);
      } catch (_) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    globals.setActivePage(0);
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      if (state is AuthentifiedState) {
        List<RecipeModel> filteredRecipes = state.filteredRecipes;
        List<RecipeModel> recipes = state.recipes;

        // Widget method to have access to state
        void filterSearchResults(String query) {
          setState(() {
            filterQuery = query;
          });
          if (query.isNotEmpty) {
            List<RecipeModel> foundRecipes = [];
            for (var recipe in recipes) {
              for (var text in query.split(" ")) {
                if (text.isNotEmpty &&
                    (!favoritesOnly || recipe.isFavorite) &&
                    (recipe.name.toLowerCase().contains(text.toLowerCase()) ||
                        recipe.category
                            .toLowerCase()
                            .contains(text.toLowerCase()))) {
                  foundRecipes.add(recipe);
                  break;
                }
              }
            }
            setState(() {
              filteredRecipes.clear();
              filteredRecipes.addAll(foundRecipes);
            });
            return;
          } else {
            setState(() {
              filteredRecipes.clear();
              if (favoritesOnly) {
                filteredRecipes
                    .addAll(recipes.where((element) => element.isFavorite));
              } else {
                filteredRecipes.addAll(recipes);
              }
            });
          }
        }

        showFavoritesOnly() {
          setState(() {
            favoritesOnly = !favoritesOnly;
          });
          filterSearchResults(filterQuery);
        }

        void updateFavoriteStatus(recipe) {
          toggleFavoriteStatus(recipe);
          filterSearchResults(filterQuery);
        }

        return Scaffold(
            body: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                padding: const EdgeInsets.only(
                    left: 10, top: 12, right: 10, bottom: 14),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('img/background-gradient.png'),
                        fit: BoxFit.fill)),
                alignment: Alignment.center,
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Material(
                        color: AppColors.backgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        child: TextField(
                          onChanged: (value) {
                            filterSearchResults(value);
                          },
                          controller: searchBoxController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(3),
                              focusColor: AppColors.highlightColor3,
                              hintText:
                                  AppLocalizations.of(context)!.global_filter,
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                  onPressed: () => showFavoritesOnly(),
                                  color: favoritesOnly
                                      ? AppColors.highlightColor3
                                      : AppColors.textColor,
                                  icon: favoritesOnly
                                      ? const Icon(Icons.star)
                                      : const Icon(Icons.star_outline)),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                        ),
                      )),
                  Expanded(
                      child: ListView.builder(
                    itemCount: filteredRecipes.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Material(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                              //Material required to solve known issue with Gesture Detector, see https://github.com/flutter/flutter/issues/83108
                              child: GestureDetector(
                                  onTap: () => BlocProvider.of<AppCubits>(context).gotoRecipeDetails(
                                      filteredRecipes[index]),
                                  child: ListTile(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomRight:
                                                  Radius.circular(30))),
                                      tileColor: AppColors.backgroundColor,
                                      leading: Container(
                                          width: MediaQuery.of(context).size.width /
                                              4,
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10)),
                                              color: AppColors.textColor,
                                              image: DecorationImage(image: NetworkImage(filteredRecipes[index].img), fit: BoxFit.fill))),
                                      title: Text(filteredRecipes[index].name),
                                      subtitle: Text(filteredRecipes[index].category),
                                      isThreeLine: false,
                                      trailing: IconButton(onPressed: () => updateFavoriteStatus(filteredRecipes[index]), color: filteredRecipes[index].isFavorite ? AppColors.starColor1 : AppColors.textColor, icon: filteredRecipes[index].isFavorite ? const Icon(Icons.star) : const Icon(Icons.star_outline))))));
                    },
                  ))
                ])));
      } else {
        return Scaffold(
            body: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('img/background-gradient.png'),
                        fit: BoxFit.fill)),
                alignment: Alignment.center,
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.3,
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {
                          BlocProvider.of<AppCubits>(context).gotoInit();
                        },
                        child: AppText(
                            text: AppLocalizations.of(context)!
                                .error_authentification,
                            color: AppColors.backgroundColor,
                            size: AppTextSize.normal,
                            fontFamily: AppFontFamily.bauhaus)))));
      }
    });
  }
}
