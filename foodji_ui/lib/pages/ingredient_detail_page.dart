import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/widgets/app_text.dart';
import '../models/recipe_ingredient_model.dart';
import '../models/recipe_substitute_model.dart';
import '../models/tags_enum.dart';
import '../widgets/ingredient_detail_substitutions.dart';
import '../widgets/stateless_app_bar.dart' as stateless_app_bar_widget;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../misc/colors.dart';

// Inner class only needed here
class TagsWithColor {
  final String tag;
  final bool isIngredients;
  TagsWithColor({required this.tag, required this.isIngredients});
}

class IngredientDetailPage extends StatefulWidget {
  const IngredientDetailPage({Key? key}) : super(key: key);

  @override
  IngredientDetailPageState createState() => IngredientDetailPageState();
}

class IngredientDetailPageState extends State<IngredientDetailPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      if (state is IngredientState) {
        TabController tabController = TabController(length: 2, vsync: this);
        RecipeIngredientModel ingredient = state.ingredient;

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

        List<TagsWithColor> tagsWithColors(ingredient) {
          List<TagsWithColor> tags = [];
          for (var i = 0; i < 12; i++) {
            if (ingredient.tags.any((t) => t == Tags.values[i].name)) {
              tags.add(
                  TagsWithColor(tag: Tags.values[i].name, isIngredients: true));
            } else if (ingredient.substitutions.any((RecipeSubstituteModel s) =>
                s.tags.any((t) => t == Tags.values[i].name))) {
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
                                  left: 14, right: 14, bottom: 14),
                              child: SizedBox(
                                  height: 20,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          tagsWithColors(ingredient).length,
                                      itemBuilder: (context, index) {
                                        return AppText(
                                            size: AppTextSize.normal,
                                            color: tagsWithColors(
                                                        ingredient)[index]
                                                    .isIngredients
                                                ? AppColors.highlightColor3
                                                : AppColors.starColor1,
                                            text: index <
                                                    tagsWithColors(ingredient)
                                                            .length -
                                                        1
                                                ? "${getTagString(tagsWithColors(ingredient)[index].tag)}, "
                                                : getTagString(tagsWithColors(
                                                        ingredient)[index]
                                                    .tag));
                                      })))
                        ]))),
                    title: AppText(
                        text: ingredient.name,
                        size: AppTextSize.normal,
                        color: AppColors.backgroundColor),
                    actions: [
                      IconButton(
                          icon: const Icon(Icons.edit_rounded),
                          color: AppColors.backgroundColor,
                          onPressed: () => {}),
                      Container(
                          margin: const EdgeInsets.only(right: 4),
                          child: IconButton(
                              icon: const Icon(Icons.arrow_back_rounded),
                              color: AppColors.backgroundColor,
                              onPressed: () =>
                                  BlocProvider.of<AppCubits>(context)
                                      .gotoIngredients()))
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
                                  .ingredient_substitutions)
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
                        // TODO - Height here causes an issue. It cannot be removed, but cannot be set to child size either.
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(
                            controller: tabController,
                            children: <Widget>[
                              IngredientDetailSubstitutions(ingredient)
                            ]))
                  ]))
                ])));
      } else {
        return SafeArea(
            child: Scaffold(
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
                                text:
                                    AppLocalizations.of(context)!.error_unknown,
                                color: AppColors.backgroundColor,
                                size: AppTextSize.normal,
                                fontFamily: AppFontFamily.bauhaus))))));
      }
    });
  }
}
