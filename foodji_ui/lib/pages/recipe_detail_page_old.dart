import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/widgets/app_text.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../misc/colors.dart';
import '../models/recipe_model.dart';
import '../widgets/app_ico_button.dart';

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({Key? key}) : super(key: key);

  @override
  RecipeDetailPageState createState() => RecipeDetailPageState();
}

class RecipeDetailPageState extends State<RecipeDetailPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      if (state is RecipeState) {
        RecipeModel recipe = state.recipe;

        topButton() {
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AppIcoButton(
                  icon: Icons.arrow_back_rounded,
                  onPressed: () =>
                      BlocProvider.of<AppCubits>(context).gotoRecipes()),
              const Spacer(),
              // TODO : Add edit action
              AppIcoButton(
                  icon: Icons.edit_rounded,
                  onPressed: () {
                    setState(() {
                      recipe = RecipeModel.getSample();
                    });
                  }),
            ]),
          ));
        }

        steps(BuildContext context) {
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recipe.steps.length,
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
                                    child: AppText(text: recipe.steps[index]))
                              ])
                            ]),
                      ),
                    ),
                  ));
        }

        ingredients(BuildContext context) {
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recipe.ingredients.length,
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
                          text: recipe.ingredients[index].name,
                        )
                      ],
                    ),
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
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
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
                                text: recipe.name,
                                size: AppTextSize.title,
                              ),
                              const Spacer(),
                              AppText(
                                text: recipe.category,
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
                                      text: '${recipe.details.totalTime} min')),
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
                          text:
                              AppLocalizations.of(context)!.recipe_description,
                          size: AppTextSize.subtitle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppText(text: recipe.desc),
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
                        recipe.ingredients.isNotEmpty
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
                        recipe.steps.isNotEmpty
                            ? steps(context)
                            : AppText(
                                text: AppLocalizations.of(context)!
                                    .recipe_no_steps),
                      ],
                    ),
                  ),
                );
              });
        }

        return SafeArea(
            child: Scaffold(
          body: Stack(children: [
            Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(recipe.img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            content(),
            topButton()
          ]),
        ));
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
