import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodji_ui/models/recipe_ingredient_model.dart';

import '../misc/colors.dart';
import '../models/recipe_model.dart';
import 'app_text.dart';

class RecipeDetailPreparation extends StatefulWidget {
  const RecipeDetailPreparation(this.recipe, this.isSelected, {super.key});
  final RecipeModel recipe;
  final List<bool> isSelected;
  @override
  RecipeDetailPreparationState createState() => RecipeDetailPreparationState();
}

class RecipeDetailPreparationState extends State<RecipeDetailPreparation> {
  ingredients(BuildContext context) {
    toggleSelected(index) {
      setState(() {
        widget.isSelected[index] = !widget.isSelected[index];
      });
    }

    CircleAvatar selectedAvatar(index) {
      return CircleAvatar(
        backgroundColor: AppColors.backgroundColor,
        child: IconButton(
          onPressed: () => toggleSelected(index),
          icon: widget.isSelected[index]
              ? const Icon(Icons.check_circle)
              : const Icon(Icons.check_circle_outline),
          iconSize: 24,
          color: widget.isSelected[index]
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

    Widget _buildIngredient(RecipeIngredientModel ingredient) {
      return IgnorePointer(
          ignoring: ingredient.substitutes.isEmpty,
          child: ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedAvatar(0),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(children: <Widget>[
                      AppText(
                        color: AppColors.textColor,
                        text: ingredient.name,
                      )
                    ])),
                const Spacer(),
                pantryAvatar(0),
                groceryListAvatar(0)
              ],
            ),
            iconColor: AppColors.textColor,
            collapsedIconColor: ingredient.substitutes.isEmpty
                ? AppColors.backgroundColor60
                : AppColors.textColor,
            children: <Widget>[
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.7,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: ingredient.substitutes.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: AppText(
                            text: ingredient.substitutes[index].name,
                            size: AppTextSize.normal,
                            color: AppColors.textColor,
                          ),
                        );
                      }))
            ],
          ));
    }

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.recipe.ingredients.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Column(children: [
                _buildIngredient(widget.recipe.ingredients[index]),
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
              text: AppLocalizations.of(context)!.recipe_ingredients,
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
