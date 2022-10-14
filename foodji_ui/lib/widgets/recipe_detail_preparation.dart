import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../misc/colors.dart';
import '../models/recipe_model.dart';
import 'app_text.dart';

class RecipeDetailPreparation extends StatefulWidget {
  const RecipeDetailPreparation(this.recipe, {super.key});
  final RecipeModel recipe;
  @override
  RecipeDetailPreparationState createState() => RecipeDetailPreparationState();
}

class RecipeDetailPreparationState extends State<RecipeDetailPreparation> {
  ingredients(BuildContext context) {
    var isSelected = List.filled(widget.recipe.ingredients.length, false);
    void toggleSelected(index) async {
      setState(() {
        isSelected[index] = !isSelected[index];
      });
    }

    CircleAvatar selectedAvatar(index) {
      return CircleAvatar(
        backgroundColor: AppColors.backgroundColor,
        child: IconButton(
          onPressed: () => toggleSelected(index),
          icon: isSelected[index]
              ? const Icon(Icons.check_circle)
              : const Icon(Icons.check_circle_outline),
          iconSize: 24,
          color: isSelected[index]
              ? AppColors.highlightColor3
              : AppColors.highlightColor2,
        ),
      );
    }

    CircleAvatar groceryListAvatar(index) {
      //TODO - Adds or removes the item from the grocery list, and changes state accordingly.
      return CircleAvatar(
        backgroundColor: AppColors.backgroundColor,
        child: IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.shopping_cart_outlined),
            iconSize: 24,
            color: AppColors.textColor),
      );
    }

    CircleAvatar pantryAvatar(index) {
      //TODO - Adds or removes the item from the pantry, and changes state accordingly.
      return CircleAvatar(
        backgroundColor: AppColors.backgroundColor,
        child: IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.kitchen_outlined),
            iconSize: 24,
            color: AppColors.textColor),
      );
    }

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.recipe.ingredients.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    selectedAvatar(index),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Column(children: <Widget>[
                          AppText(
                            color: AppColors.textColor,
                            text: widget.recipe.ingredients[index].name,
                          )
                        ])),
                    const Spacer(),
                    pantryAvatar(index),
                    groceryListAvatar(index)
                  ],
                ),
                Row(children: const <Widget>[
                  Expanded(child: Divider(thickness: 1))
                ])
              ]),
            ));
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
                  .recipe_detail_preparation_ingredients,
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
