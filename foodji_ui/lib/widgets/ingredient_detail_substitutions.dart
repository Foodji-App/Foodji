import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../misc/colors.dart';
import '../models/recipe_ingredient_model.dart';
import 'app_text.dart';

class IngredientDetailSubstitutions extends StatefulWidget {
  const IngredientDetailSubstitutions(this.ingredient, {super.key});
  final RecipeIngredientModel ingredient;
  @override
  IngredientDetailSubstitutionsState createState() =>
      IngredientDetailSubstitutionsState();
}

class IngredientDetailSubstitutionsState
    extends State<IngredientDetailSubstitutions> {
  ingredients(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.ingredient.substitutes.length,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const SizedBox(width: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    children: <Widget>[
                      AppText(
                          color: AppColors.textColor,
                          text: widget.ingredient.substitutes[index].name),
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
          widget.ingredient.substitutes.isNotEmpty
              ? ingredients(context)
              : AppText(
                  text: AppLocalizations.of(context)!.recipe_no_ingredients)
        ]));
  }
}
