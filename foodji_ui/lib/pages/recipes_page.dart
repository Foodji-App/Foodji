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
  List<bool> advancedFilters = List.filled(12, false);
  bool advancedFilterSelected = false;

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

        void toggleAdvancedFilter(index) {
          setState(() {
            advancedFilters[index] = !advancedFilters[index];
            if (advancedFilters[index]) {
              advancedFilterSelected = true;
            } else {
              advancedFilterSelected = false;
              for (var i = 0; i < 12; i++) {
                if (advancedFilters[i]) {
                  advancedFilterSelected = true;
                  break;
                }
              }
            }
          });
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
                child: Column(children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Material(
                        color: AppColors.backgroundColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
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
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)))),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Material(
                          color: AppColors.textColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(20)),
                          child: ExpansionTile(
                              title: AppText(
                                text: AppLocalizations.of(context)!.tag_filter,
                                size: AppTextSize.normal,
                                color: advancedFilterSelected
                                    ? AppColors.highlightColor3
                                    : AppColors.backgroundColor,
                                backgroundColor: Colors.transparent,
                              ),
                              iconColor: advancedFilterSelected
                                  ? AppColors.highlightColor3
                                  : AppColors.backgroundColor,
                              collapsedIconColor: advancedFilterSelected
                                  ? AppColors.highlightColor3
                                  : AppColors.backgroundColor,
                              children: <Widget>[
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: AppText(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .tag_vegan,
                                              size: AppTextSize.normal,
                                              color: advancedFilters[0]
                                                  ? AppColors.highlightColor3
                                                  : AppColors.backgroundColor,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            trailing: advancedFilters[0]
                                                ? const Icon(Icons.check,
                                                    color: AppColors
                                                        .highlightColor3)
                                                : const SizedBox(
                                                    width: 0, height: 0),
                                            onTap: () =>
                                                toggleAdvancedFilter(0),
                                          ),
                                          ListTile(
                                            title: AppText(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .tag_vegetarian,
                                              size: AppTextSize.normal,
                                              color: advancedFilters[1]
                                                  ? AppColors.highlightColor3
                                                  : AppColors.backgroundColor,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            trailing: advancedFilters[1]
                                                ? const Icon(Icons.check,
                                                    color: AppColors
                                                        .highlightColor3)
                                                : const SizedBox(
                                                    width: 0, height: 0),
                                            onTap: () =>
                                                toggleAdvancedFilter(1),
                                          ),
                                          ListTile(
                                            title: AppText(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .tag_gluten_free,
                                              size: AppTextSize.normal,
                                              color: advancedFilters[2]
                                                  ? AppColors.highlightColor3
                                                  : AppColors.backgroundColor,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            trailing: advancedFilters[2]
                                                ? const Icon(Icons.check,
                                                    color: AppColors
                                                        .highlightColor3)
                                                : const SizedBox(
                                                    width: 0, height: 0),
                                            onTap: () =>
                                                toggleAdvancedFilter(2),
                                          ),
                                          ListTile(
                                            title: AppText(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .tag_gluten_free,
                                              size: AppTextSize.normal,
                                              color: advancedFilters[3]
                                                  ? AppColors.highlightColor3
                                                  : AppColors.backgroundColor,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            trailing: advancedFilters[3]
                                                ? const Icon(Icons.check,
                                                    color: AppColors
                                                        .highlightColor3)
                                                : const SizedBox(
                                                    width: 0, height: 0),
                                            onTap: () =>
                                                toggleAdvancedFilter(3),
                                          ),
                                          ListTile(
                                            title: AppText(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .tag_nut_free,
                                              size: AppTextSize.normal,
                                              color: advancedFilters[4]
                                                  ? AppColors.highlightColor3
                                                  : AppColors.backgroundColor,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            trailing: advancedFilters[4]
                                                ? const Icon(Icons.check,
                                                    color: AppColors
                                                        .highlightColor3)
                                                : const SizedBox(
                                                    width: 0, height: 0),
                                            onTap: () =>
                                                toggleAdvancedFilter(4),
                                          ),
                                          ListTile(
                                            title: AppText(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .tag_peanut_free,
                                              size: AppTextSize.normal,
                                              color: advancedFilters[5]
                                                  ? AppColors.highlightColor3
                                                  : AppColors.backgroundColor,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            trailing: advancedFilters[5]
                                                ? const Icon(Icons.check,
                                                    color: AppColors
                                                        .highlightColor3)
                                                : const SizedBox(
                                                    width: 0, height: 0),
                                            onTap: () =>
                                                toggleAdvancedFilter(5),
                                          ),
                                          ListTile(
                                            title: AppText(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .tag_lactose_free,
                                              size: AppTextSize.normal,
                                              color: advancedFilters[6]
                                                  ? AppColors.highlightColor3
                                                  : AppColors.backgroundColor,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            trailing: advancedFilters[6]
                                                ? const Icon(Icons.check,
                                                    color: AppColors
                                                        .highlightColor3)
                                                : const SizedBox(
                                                    width: 0, height: 0),
                                            onTap: () =>
                                                toggleAdvancedFilter(6),
                                          ),
                                          ListTile(
                                            title: AppText(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .tag_milk_free,
                                              size: AppTextSize.normal,
                                              color: advancedFilters[7]
                                                  ? AppColors.highlightColor3
                                                  : AppColors.backgroundColor,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            trailing: advancedFilters[7]
                                                ? const Icon(Icons.check,
                                                    color: AppColors
                                                        .highlightColor3)
                                                : const SizedBox(
                                                    width: 0, height: 0),
                                            onTap: () =>
                                                toggleAdvancedFilter(7),
                                          ),
                                          ListTile(
                                            title: AppText(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .tag_wheat_free,
                                              size: AppTextSize.normal,
                                              color: advancedFilters[8]
                                                  ? AppColors.highlightColor3
                                                  : AppColors.backgroundColor,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            trailing: advancedFilters[8]
                                                ? const Icon(Icons.check,
                                                    color: AppColors
                                                        .highlightColor3)
                                                : const SizedBox(
                                                    width: 0, height: 0),
                                            onTap: () =>
                                                toggleAdvancedFilter(8),
                                          ),
                                          ListTile(
                                            title: AppText(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .tag_seafood_free,
                                              size: AppTextSize.normal,
                                              color: advancedFilters[9]
                                                  ? AppColors.highlightColor3
                                                  : AppColors.backgroundColor,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            trailing: advancedFilters[9]
                                                ? const Icon(Icons.check,
                                                    color: AppColors
                                                        .highlightColor3)
                                                : const SizedBox(
                                                    width: 0, height: 0),
                                            onTap: () =>
                                                toggleAdvancedFilter(9),
                                          ),
                                          ListTile(
                                            title: AppText(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .tag_halal,
                                              size: AppTextSize.normal,
                                              color: advancedFilters[10]
                                                  ? AppColors.highlightColor3
                                                  : AppColors.backgroundColor,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            trailing: advancedFilters[10]
                                                ? const Icon(Icons.check,
                                                    color: AppColors
                                                        .highlightColor3)
                                                : const SizedBox(
                                                    width: 0, height: 0),
                                            onTap: () =>
                                                toggleAdvancedFilter(10),
                                          ),
                                          ListTile(
                                            title: AppText(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .tag_kosher,
                                              size: AppTextSize.normal,
                                              color: advancedFilters[11]
                                                  ? AppColors.highlightColor3
                                                  : AppColors.backgroundColor,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            trailing: advancedFilters[11]
                                                ? const Icon(Icons.check,
                                                    color: AppColors
                                                        .highlightColor3)
                                                : const SizedBox(
                                                    width: 0, height: 0),
                                            onTap: () =>
                                                toggleAdvancedFilter(11),
                                          ),
                                        ],
                                      ),
                                    ))
                              ]))),
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
