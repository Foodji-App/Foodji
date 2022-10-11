import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../misc/colors.dart';
import '../models/recipe_model.dart';
import 'app_text.dart';

class RecipeDetailInstructions extends StatefulWidget {
  const RecipeDetailInstructions(this.recipe, {super.key});
  final RecipeModel recipe;
  @override
  RecipeDetailInstructionsState createState() =>
      RecipeDetailInstructionsState();
}

class RecipeDetailInstructionsState extends State<RecipeDetailInstructions> {
  ingredients(BuildContext context) {
    var isSelected = List.filled(widget.recipe.steps.length, false);
    void toggleSelected(index) async {
      setState(() {
        isSelected[index] = !isSelected[index];
      });
    }

    CircleAvatar selectedAvatar(index) {
      return CircleAvatar(
          backgroundColor: AppColors.backgroundColor,
          child: GestureDetector(
              onTap: () => toggleSelected(index),
              child: Chip(
                clipBehavior: Clip.none,
                backgroundColor: AppColors.backgroundColor,
                label: AppText(
                  color: isSelected[index]
                      ? AppColors.highlightColor3
                      : AppColors.highlightColor2,
                  text: (index + 1).toString(),
                ),
                shape: StadiumBorder(
                    side: BorderSide(
                  width: 2,
                  color: isSelected[index]
                      ? AppColors.highlightColor3
                      : AppColors.highlightColor2,
                )),
              )));
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.recipe.steps.length,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                selectedAvatar(index),
                const SizedBox(width: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    children: <Widget>[
                      AppText(
                          color: AppColors.textColor,
                          text: widget.recipe.steps[index]),
                    ],
                  ),
                ),
                const Spacer()
              ]),
              Row(children: const <Widget>[
                Expanded(child: Divider(thickness: 1))
              ])
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: <Widget>[
            const Expanded(
                child: Divider(
              thickness: 2,
              endIndent: 5,
            )),
            AppText(
              text: AppLocalizations.of(context)!
                  .recipe_detail_instructions_instructions,
              size: AppTextSize.subtitle,
            ),
            const Expanded(child: Divider(thickness: 2, indent: 5)),
          ]),
          const SizedBox(
            height: 10,
          ),
          widget.recipe.ingredients.isNotEmpty
              ? ingredients(context)
              : AppText(
                  text: AppLocalizations.of(context)!.recipe_no_ingredients)
        ]));
  }
}
