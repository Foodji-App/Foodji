import 'package:flutter/material.dart';
import 'package:foodji_ui/widgets/app_text.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../misc/colors.dart';
import '../models/recipe_model.dart';
import '../widgets/dial_button.dart';

class DetailedRecipePage extends StatefulWidget {
  const DetailedRecipePage({Key? key}) : super(key: key);

  @override
  _DetailedRecipePageState createState() => _DetailedRecipePageState();
}

class _DetailedRecipePageState extends State<DetailedRecipePage>
    with TickerProviderStateMixin {
  RecipeModel _recipe = RecipeModel.getSample();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        Container(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(_recipe.img),
              fit: BoxFit.cover,
            ),
          ),
        ),
        content(),
        topButton()
      ]),
    ));
  }

  topButton() {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // TODO : Connect to router
        DialButton(icon: Icons.arrow_back_rounded, onPressed: () {}),
        const Spacer(),
        // TODO : Add edit action
        DialButton(
            icon: Icons.edit_rounded,
            onPressed: () {
              setState(() {
                _recipe = RecipeModel.getSample();
              });
            }),
      ]),
    ));
  }

  content() {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Barette grise
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 35,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: double.maxFinite,
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: _recipe.name,
                          size: AppTextSize.title,
                        ),
                        const Spacer(),
                        AppText(
                          text: _recipe.category,
                          size: AppTextSize.small,
                          color: AppColors.backgroundColor,
                          backgroundColor: AppColors.highlightColor3,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    width: double.maxFinite,
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Chip(
                            backgroundColor: AppColors.highlightColor2,
                            avatar: const CircleAvatar(
                              backgroundColor: AppColors.none,
                              child: Icon(
                                Icons.timer_rounded,
                                color: Colors.white,
                              ),
                            ),
                            label: AppText(
                                text: '${_recipe.details.totalTime} min')),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  AppText(
                    text: AppLocalizations.of(context)!
                        .recipe_description,
                    size: AppTextSize.subtitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText(text: _recipe.desc),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),

                  // Ingrédients
                  AppText(
                    text: AppLocalizations.of(context)!.menu_ingredients,
                    size: AppTextSize.subtitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _recipe.ingredients.isNotEmpty
                      ? ingredients(context)
                      : AppText(
                          text: AppLocalizations.of(context)!
                              .recipe_no_ingredients),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),

                  // Instructions
                  AppText(
                    text: AppLocalizations.of(context)!.recipe_steps,
                    size: AppTextSize.subtitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _recipe.steps.isNotEmpty
                      ? steps(context)
                      : AppText(
                          text: AppLocalizations.of(context)!.recipe_no_steps),
                ],
              ),
            ),
          );
        });
  }

  ingredients(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _recipe.ingredients.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 10,
                    backgroundColor: AppColors.backgroundColor,
                    child: Icon(
                      Icons.done,
                      size: 15,
                      color: AppColors.highlightColor2,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  AppText(
                    color: AppColors.textColor,
                    text: _recipe.ingredients[index].name,
                  )
                ],
              ),
            ));
  }

  steps(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _recipe.steps.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.highlightColor3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.highlightColor2,
                          child: AppText(
                            color: AppColors.backgroundColor,
                            text: (index + 1).toString(),
                          ),
                        ),
                        Column(children: [
                          SizedBox(
                              width: 280,
                              child: AppText(text: _recipe.steps[index]))
                        ])
                      ]),
                ),
              ),
            ));
  }
}
