import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/widgets/app_text.dart';
import '../models/categories_enum.dart';
import '../models/recipe_ingredient_model.dart';
import '../models/recipe_substitute_model.dart';
import '../models/tags_enum.dart';
import '../widgets/recipe_detail_instructions.dart';
import '../widgets/recipe_detail_preparation.dart';
import '../widgets/stateless_app_bar.dart' as stateless_app_bar_widget;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../misc/colors.dart';
import '../models/recipe_model.dart';
import 'error_page.dart';

// Inner class only needed here
class TagsWithColor {
  final String tag;
  final bool isIngredients;
  TagsWithColor({required this.tag, required this.isIngredients});
}

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({Key? key}) : super(key: key);

  @override
  RecipeDetailPageState createState() => RecipeDetailPageState();
}

class RecipeDetailPageState extends State<RecipeDetailPage>
    with TickerProviderStateMixin {
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
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      if (state is RecipeState) {
        TabController tabController = TabController(length: 2, vsync: this);
        RecipeModel recipe = state.recipe;

        String getTagString(tag) {
          if (tag == Tags.vegan.name) {
            return AppLocalizations.of(context)!.tag_vegan;
          } else if (tag == Tags.vegetarian.name) {
            return AppLocalizations.of(context)!.tag_vegetarian;
          } else if (tag == Tags.glutenFree.name) {
            return AppLocalizations.of(context)!.tag_gluten_free;
          } else if (tag == Tags.soyFree.name) {
            return AppLocalizations.of(context)!.tag_soy_free;
          } else if (tag == Tags.eggFree.name) {
            return AppLocalizations.of(context)!.tag_egg_free;
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
            return tag;
          }
        }

        String getCategoryString(category) {
          if (category == Categories.mainCourse.name) {
            return AppLocalizations.of(context)!.category_main_course;
          } else if (category == Categories.sideDish.name) {
            return AppLocalizations.of(context)!.category_side_dish;
          } else if (category == Categories.appetizer.name) {
            return AppLocalizations.of(context)!.category_appetizer;
          } else if (category == Categories.dessert.name) {
            return AppLocalizations.of(context)!.category_dessert;
          } else if (category == Categories.lunch.name) {
            return AppLocalizations.of(context)!.category_lunch;
          } else if (category == Categories.breakfast.name) {
            return AppLocalizations.of(context)!.category_breakfast;
          } else if (category == Categories.beverage.name) {
            return AppLocalizations.of(context)!.category_beverage;
          } else if (category == Categories.soup.name) {
            return AppLocalizations.of(context)!.category_soup;
          } else if (category == Categories.sauce.name) {
            return AppLocalizations.of(context)!.category_sauce;
          } else if (category == Categories.bread.name) {
            return AppLocalizations.of(context)!.category_bread;
          } else if (category == Categories.snack.name) {
            return AppLocalizations.of(context)!.category_snack;
          } else {
            return "";
          }
        }

        List<TagsWithColor> tagsWithColors(recipe) {
          List<TagsWithColor> tags = [];
          for (var i = 0; i < 12; i++) {
            if (recipe.ingredients.any((RecipeIngredientModel ig) =>
                ig.tags.any((t) => t == Tags.values[i].name))) {
              tags.add(
                  TagsWithColor(tag: Tags.values[i].name, isIngredients: true));
            } else if (recipe.ingredients.any((RecipeIngredientModel ig) =>
                ig.substitutes.any((RecipeSubstituteModel s) =>
                    s.tags.any((t) => t == Tags.values[i].name)))) {
              tags.add(TagsWithColor(
                  tag: Tags.values[i].name, isIngredients: false));
            }
          }
          return tags;
        }

        return SafeArea(
            child: Scaffold(
                appBar: stateless_app_bar_widget.AppBar(
                    AppLocalizations.of(context)!.app_bar_recipe_details),
                backgroundColor: AppColors.backgroundColor,
                body: CustomScrollView(slivers: [
                  SliverAppBar(
                    backgroundColor: AppColors.textColor,
                    foregroundColor: AppColors.backgroundColor,
                    flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: SafeArea(
                            child: Column(children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 55, left: 14, right: 14, bottom: 20),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 3.5,
                                  alignment: Alignment.center,
                                  decoration: recipe.imageUri != ""
                                      ? BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(recipe.imageUri),
                                              fit: BoxFit.cover))
                                      : null,
                                  child: recipe.imageUri == ""
                                      ? AppText(
                                          size: AppTextSize.title,
                                          color: AppColors.backgroundColor,
                                          text: AppLocalizations.of(context)!
                                              .no_image)
                                      : null)),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Chip(
                                    clipBehavior: Clip.none,
                                    backgroundColor: AppColors.textColor,
                                    label: AppText(
                                        size: AppTextSize.small,
                                        color: AppColors.backgroundColor,
                                        text:
                                            getCategoryString(recipe.category)),
                                    shape: const StadiumBorder(
                                        side: BorderSide(
                                      width: 1,
                                      color: AppColors.highlightColor3,
                                    )),
                                  ),
                                  const Spacer(),
                                  Chip(
                                    clipBehavior: Clip.none,
                                    backgroundColor: AppColors.textColor,
                                    avatar: const CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Icon(
                                        Icons.restaurant_menu_outlined,
                                        color: AppColors.backgroundColor,
                                      ),
                                    ),
                                    label: AppText(
                                        color: AppColors.backgroundColor,
                                        text: '${recipe.details.serves}'),
                                    shape: const StadiumBorder(
                                        side: BorderSide(
                                      width: 1,
                                      color: AppColors.highlightColor2,
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Chip(
                                        clipBehavior: Clip.none,
                                        backgroundColor: AppColors.textColor,
                                        avatar: const CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: Icon(
                                            Icons.timer_rounded,
                                            color: AppColors.backgroundColor,
                                          ),
                                        ),
                                        label: AppText(
                                            color: AppColors.backgroundColor,
                                            text:
                                                '${recipe.details.totalTime ?? '?'} ${AppLocalizations.of(context)!.minutes}'),
                                        shape: const StadiumBorder(
                                            side: BorderSide(
                                          width: 1,
                                          color: AppColors.starColor1,
                                        ))),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, bottom: 14),
                              child: SizedBox(
                                  height: 20,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: tagsWithColors(recipe).length,
                                      itemBuilder: (context, index) {
                                        return AppText(
                                            size: AppTextSize.normal,
                                            color: tagsWithColors(recipe)[index]
                                                    .isIngredients
                                                ? AppColors.backgroundColor
                                                : AppColors.starColor1,
                                            text: index <
                                                    tagsWithColors(recipe)
                                                            .length -
                                                        1
                                                ? "${getTagString(tagsWithColors(recipe)[index].tag)}, "
                                                : getTagString(tagsWithColors(
                                                        recipe)[index]
                                                    .tag));
                                      }))),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              child: AppText(
                                  text: recipe.description,
                                  color: AppColors.backgroundColor,
                                  size: AppTextSize.normal,
                                  fontFamily: AppFontFamily.bauhaus))
                        ]))),
                    title: AppText(
                        text: recipe.name,
                        size: AppTextSize.normal,
                        color: AppColors.backgroundColor),
                    actions: [
                      IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          color: AppColors.backgroundColor,
                          onPressed: () => BlocProvider.of<AppCubits>(context)
                              .gotoRecipeEditor(recipe)),
                      IconButton(
                          icon: recipe.isFavorite
                              ? const Icon(Icons.star)
                              : const Icon(Icons.star_outline),
                          color: recipe.isFavorite
                              ? AppColors.starColor1
                              : AppColors.backgroundColor,
                          onPressed: () => toggleFavoriteStatus(recipe)),
                      Container(
                          margin: const EdgeInsets.only(right: 4),
                          child: IconButton(
                              icon: const Icon(Icons.arrow_back_rounded),
                              color: AppColors.backgroundColor,
                              onPressed: () =>
                                  BlocProvider.of<AppCubits>(context)
                                      .gotoRecipes()))
                    ],
                    pinned: true,
                    expandedHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  SliverAppBar(
                    backgroundColor: AppColors.textColor,
                    foregroundColor: AppColors.textColor,
                    title: Material(
                        color: AppColors.textColor,
                        child: TabBar(controller: tabController, tabs: <Tab>[
                          Tab(
                              text: AppLocalizations.of(context)!
                                  .recipe_preparation),
                          Tab(
                              text: AppLocalizations.of(context)!
                                  .recipe_instructions)
                        ])),
                    pinned: true,
                    toolbarHeight: 50,
                    expandedHeight: 50,
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    // ignore: sized_box_for_whitespace
                    Container(
                        // Container is mandatory here, do not remove
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(controller: tabController, children: <
                            Widget>[
                          RecipeDetailPreparation(recipe,
                              List.filled(recipe.ingredients.length, false)),
                          RecipeDetailInstructions(
                              recipe, List.filled(recipe.steps.length, false))
                        ]))
                  ]))
                ])));
      } else {
        return const ErrorPage();
      }
    });
  }
}
