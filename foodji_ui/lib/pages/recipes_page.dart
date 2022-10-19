import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodji_ui/models/recipe_model.dart';
import 'package:foodji_ui/models/tags_enum.dart';

import '../cubit/app_globals.dart' as globals;
import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../misc/colors.dart';
import '../models/categories_enum.dart';
import '../models/ingredient_model.dart';
import '../models/substitution_model.dart';
import '../widgets/app_text.dart';

// Inner class only needed here
class TagsWithColor {
  final String tag;
  final bool isIngredients;
  TagsWithColor({required this.tag, required this.isIngredients});
}

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
  dynamic category;
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
        List<RecipeModel> applyAdvancedFilters(recipes) {
          if (advancedFilterSelected) {
            for (var i = 0; i < 12; i++) {
              if (advancedFilters[i]) {
                setState(() {
                  recipes = recipes
                      .where((RecipeModel r) => r.ingredients.any(
                          (IngredientModel ig) =>
                              ig.tags.any((t1) => t1 == Tags.values[i].name) ||
                              ig.substitutions.any((SubstitutionModel s) => s
                                  .tags
                                  .any((t2) => t2 == Tags.values[i].name))))
                      .toList();
                });
              }
            }
          }
          return recipes;
        }

        void filterSearchResults(String query) {
          setState(() {
            filterQuery = query;
          });
          List<RecipeModel> foundRecipes = [];
          if (query.isNotEmpty) {
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
              foundRecipes = applyAdvancedFilters(foundRecipes);
              filteredRecipes.clear();
              filteredRecipes.addAll(foundRecipes);
            });
            return;
          } else {
            setState(() {
              foundRecipes = applyAdvancedFilters(recipes);
              filteredRecipes.clear();
              if (favoritesOnly) {
                filteredRecipes.addAll(
                    foundRecipes.where((element) => element.isFavorite));
              } else {
                filteredRecipes.addAll(foundRecipes);
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
          filterSearchResults(filterQuery);
        }

        void toggleCategoryFilter(index) {
          setState(() {
            if (category != Categories.values[index].name) {
              category = Categories.values[index].name;
            } else {
              category = null;
            }
          });
          filterSearchResults(filterQuery);
        }

        void updateFavoriteStatus(recipe) {
          toggleFavoriteStatus(recipe);
          filterSearchResults(filterQuery);
        }

        String getTagString(tag) {
          if (tag == Tags.vegan.name) {
            return AppLocalizations.of(context)!.tag_vegan;
          } else if (tag == Tags.vegetarian.name) {
            return AppLocalizations.of(context)!.tag_vegetarian;
          } else if (tag == Tags.glutenFree.name) {
            return AppLocalizations.of(context)!.tag_gluten_free;
          } else if (tag == Tags.soyFree.name) {
            return AppLocalizations.of(context)!.tag_soy_free;
          } else if (tag == Tags.nutFree.name) {
            return AppLocalizations.of(context)!.tag_nut_free;
          } else if (tag == Tags.peanutFree.name) {
            return AppLocalizations.of(context)!.tag_peanut_free;
          } else if (tag == Tags.lactoseFree.name) {
            return AppLocalizations.of(context)!.tag_lactose_free;
          } else if (tag == Tags.milkFree.name) {
            return AppLocalizations.of(context)!.tag_milk_free;
          } else if (tag == Tags.wheatFree.name) {
            return AppLocalizations.of(context)!.tag_wheat_free;
          } else if (tag == Tags.seafoodFree.name) {
            return AppLocalizations.of(context)!.tag_seafood_free;
          } else if (tag == Tags.halal.name) {
            return AppLocalizations.of(context)!.tag_halal;
          } else if (tag == Tags.kosher.name) {
            return AppLocalizations.of(context)!.tag_kosher;
          } else {
            return "";
          }
        }

        String getCategoryString(category) {
          if (category == Categories.breakfast.name) {
            return AppLocalizations.of(context)!.category_breakfast;
          } else if (category == Categories.lunch.name) {
            return AppLocalizations.of(context)!.category_lunch;
          } else if (category == Categories.diner.name) {
            return AppLocalizations.of(context)!.category_diner;
          } else if (category == Categories.dessert.name) {
            return AppLocalizations.of(context)!.category_dessert;
          } else if (category == Categories.snack.name) {
            return AppLocalizations.of(context)!.category_snack;
          } else if (category == Categories.beverage.name) {
            return AppLocalizations.of(context)!.category_beverage;
          } else {
            return "";
          }
        }

        List<TagsWithColor> tagsWithColors(recipe) {
          List<TagsWithColor> tags = [];
          for (var i = 0; i < 12; i++) {
            if (recipe.ingredients.any((IngredientModel ig) =>
                ig.tags.any((t) => t == Tags.values[i].name))) {
              tags.add(
                  TagsWithColor(tag: Tags.values[i].name, isIngredients: true));
            } else if (recipe.ingredients.any((IngredientModel ig) =>
                ig.substitutions.any((SubstitutionModel s) =>
                    s.tags.any((t) => t == Tags.values[i].name)))) {
              tags.add(TagsWithColor(
                  tag: Tags.values[i].name, isIngredients: false));
            }
          }
          return tags;
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
                      padding: const EdgeInsets.all(0),
                      child: Material(
                        color: AppColors.highlightColor3,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0)),
                        child: ExpansionTile(
                          title: AppText(
                            text: category == null
                                ? AppLocalizations.of(context)!.category_filter
                                : getCategoryString(category),
                            size: AppTextSize.normal,
                            color: category != null
                                ? AppColors.textColor
                                : AppColors.backgroundColor,
                            backgroundColor: Colors.transparent,
                          ),
                          iconColor: category != null
                              ? AppColors.textColor
                              : AppColors.backgroundColor,
                          collapsedIconColor: category != null
                              ? AppColors.textColor
                              : AppColors.backgroundColor,
                          children: <Widget>[
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 2.7,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: 6,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: AppText(
                                          text: getCategoryString(
                                              Categories.values[index].name),
                                          size: AppTextSize.normal,
                                          color: category ==
                                                  Categories.values[index].name
                                              ? AppColors.textColor
                                              : AppColors.backgroundColor,
                                          backgroundColor: Colors.transparent,
                                        ),
                                        trailing: category ==
                                                Categories.values[index].name
                                            ? const Icon(Icons.check,
                                                color: AppColors.textColor)
                                            : const SizedBox(
                                                width: 0, height: 0),
                                        onTap: () =>
                                            toggleCategoryFilter(index),
                                      );
                                    }))
                          ],
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
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: 12,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: AppText(
                                          text: getTagString(
                                              Tags.values[index].name),
                                          size: AppTextSize.normal,
                                          color: advancedFilters[index]
                                              ? AppColors.highlightColor3
                                              : AppColors.backgroundColor,
                                          backgroundColor: Colors.transparent,
                                        ),
                                        trailing: advancedFilters[index]
                                            ? const Icon(Icons.check,
                                                color:
                                                    AppColors.highlightColor3)
                                            : const SizedBox(
                                                width: 0, height: 0),
                                        onTap: () =>
                                            toggleAdvancedFilter(index),
                                      );
                                    }))
                          ],
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
                                  onTap: () =>
                                      BlocProvider.of<AppCubits>(context)
                                          .gotoRecipeDetails(
                                              filteredRecipes[index]),
                                  child: ListTile(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomRight:
                                                  Radius.circular(30))),
                                      tileColor: AppColors.backgroundColor,
                                      leading: Container(
                                          width:
                                              MediaQuery.of(context).size.width /
                                                  4,
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              color: AppColors.textColor,
                                              image: DecorationImage(
                                                  image: NetworkImage(filteredRecipes[index].img),
                                                  fit: BoxFit.fill))),
                                      title: Text(filteredRecipes[index].name),
                                      subtitle: SizedBox(
                                          child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        Text(getCategoryString(
                                            filteredRecipes[index].category)),
                                        SizedBox(
                                            height: 20,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: tagsWithColors(
                                                        filteredRecipes[index])
                                                    .length,
                                                itemBuilder:
                                                    (context, indexSecondary) {
                                                  return AppText(
                                                      size: AppTextSize.small,
                                                      color: tagsWithColors(
                                                                      filteredRecipes[
                                                                          index])[
                                                                  indexSecondary]
                                                              .isIngredients
                                                          ? AppColors
                                                              .highlightColor3
                                                          : AppColors.textColor,
                                                      text: indexSecondary <
                                                              tagsWithColors(filteredRecipes[
                                                                          index])
                                                                      .length -
                                                                  1
                                                          ? "${getTagString(tagsWithColors(filteredRecipes[index])[indexSecondary].tag)}, "
                                                          : getTagString(
                                                              tagsWithColors(filteredRecipes[
                                                                          index])[
                                                                      indexSecondary]
                                                                  .tag));
                                                }))
                                      ])),
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
