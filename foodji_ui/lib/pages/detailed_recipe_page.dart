import 'package:flutter/material.dart';
import 'package:foodji_ui/models/recipe_model.dart';

import '../misc/colors.dart';
import 'detailed_recipe/show_recipe_ingredients.dart';
import 'detailed_recipe/show_recipe_steps.dart';

class DetailedRecipePage extends StatefulWidget {
  const DetailedRecipePage({Key? key}) : super(key: key);

  @override
  DetailedRecipePageState createState() => DetailedRecipePageState();
}

class DetailedRecipePageState extends State<DetailedRecipePage>
    with TickerProviderStateMixin {
  final RecipeModel _recipe = RecipeModel.getSample();

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    const tabs = [
      Tab(text: "Description"),
      Tab(text: "Ingrédients"),
      Tab(text: "Étapes")
    ];

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            // --- recipe picture ---
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 350,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(_recipe.img), fit: BoxFit.cover),
                  ),
                )),
            // --- top buttons ---
            Positioned(
                left: 20,
                right: 20,
                top: 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                        color: Colors.white),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                        color: Colors.white),
                  ],
                )),
            // --- content ---

            Positioned(
              top: 300,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: kToolbarHeight,
                padding:
                    const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
                decoration: const BoxDecoration(
                  color: AppColors.highlightColor2,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                ),
                child: Column(
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: TabBar(
                            controller: tabController,
                            indicator: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0)),
                                color: Colors.white),
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.white,
                            tabs: tabs),
                      ),
                    ),

                    Container(
                      height: 500,
                      width: double.maxFinite,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          Center(child: Text(_recipe.desc)),
                          ShowRecipeIngredients(
                              ingredients: _recipe.ingredients),
                          ShowRecipeSteps(steps: _recipe.steps),
                        ],
                      ),
                    ),
                    // Requirements ; Step
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
