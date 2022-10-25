import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/widgets/app_text.dart';
import '../widgets/recipe_detail_instructions.dart';
import '../widgets/recipe_detail_preparation.dart';
import '../widgets/stateless_app_bar.dart' as stateless_app_bar_widget;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../misc/colors.dart';
import '../models/recipe_model.dart';
import 'error_page.dart';

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
                              child: Card(
                                  elevation: 4.0,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          bottomRight: Radius.circular(40)),
                                      side: BorderSide(
                                          width: 2,
                                          color: AppColors.backgroundColor)),
                                  child: Center(
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(40),
                                              bottomRight: Radius.circular(40)),
                                          child: Image(
                                              image: NetworkImage(recipe.imageUri),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width))))),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 14),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Chip(
                                    clipBehavior: Clip.none,
                                    backgroundColor: AppColors.textColor,
                                    label: AppText(
                                        color: AppColors.backgroundColor,
                                        text: recipe.category),
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
                                                '${recipe.details.totalTime} ${AppLocalizations.of(context)!.recipe_detail_minutes}'),
                                        shape: const StadiumBorder(
                                            side: BorderSide(
                                          width: 1,
                                          color: AppColors.starColor1,
                                        ))),
                                  ),
                                ],
                              )),
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
                                  .recipe_detail_preparation),
                          Tab(
                              text: AppLocalizations.of(context)!
                                  .recipe_detail_instructions)
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
                        // FIXME - Height here causes an issue. It cannot be removed, but cannot be set to child size either.
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(
                            controller: tabController,
                            children: <Widget>[
                              RecipeDetailPreparation(recipe),
                              RecipeDetailInstructions(recipe)
                            ]))
                  ]))
                ])));
      } else {
        return const ErrorPage();
      }
    });
  }
}
