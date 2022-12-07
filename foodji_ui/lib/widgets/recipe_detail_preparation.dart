import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodji_ui/models/measurement_model.dart';
import 'package:foodji_ui/models/recipe_ingredient_model.dart';
import 'package:foodji_ui/models/recipe_substitute_model.dart';

import '../misc/colors.dart';
import '../models/recipe_model.dart';
import '../models/tags_enum.dart';
import '../models/unit_type_enum.dart';
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

    String getUnitTypeString(context, unitType) {
      if (unitType == UnitType.cup.name) {
        return AppLocalizations.of(context)!.unit_type_cup;
      } else if (unitType == UnitType.tablespoon.name) {
        return AppLocalizations.of(context)!.unit_type_tablespoon;
      } else if (unitType == UnitType.fluidOunce.name) {
        return AppLocalizations.of(context)!.unit_type_fluidOunce;
      } else if (unitType == UnitType.gram.name) {
        return AppLocalizations.of(context)!.unit_type_gram;
      } else if (unitType == UnitType.kilogram.name) {
        return AppLocalizations.of(context)!.unit_type_kilogram;
      } else if (unitType == UnitType.liter.name) {
        return AppLocalizations.of(context)!.unit_type_liter;
      } else if (unitType == UnitType.milliliter.name) {
        return AppLocalizations.of(context)!.unit_type_milliliter;
      } else if (unitType == UnitType.ounce.name) {
        return AppLocalizations.of(context)!.unit_type_ounce;
      } else if (unitType == UnitType.pound.name) {
        return AppLocalizations.of(context)!.unit_type_pound;
      } else if (unitType == UnitType.teaspoon.name) {
        return AppLocalizations.of(context)!.unit_type_teaspoon;
      } else if (unitType == UnitType.unit.name) {
        return AppLocalizations.of(context)!.unit_type_unit;
      }
      return "";
    }

    String getTagString(context, tag) {
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

    String displayMeasurement(MeasurementModel measurement) {
      var result = "";
      if (measurement.value != 0) {
        result =
            "${measurement.value} ${getUnitTypeString(context, measurement.unitType)}";
      }
      if (measurement.alternativeText.isNotEmpty) {
        if (result.isNotEmpty) {
          result += ", ";
        }
        result += measurement.alternativeText;
      }

      return result;
    }

    showSubstitutionPrecisions(substitutionPrecisions) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: AppText(text: substitutionPrecisions),
              actions: [
                TextButton(
                  child: const AppText(text: 'Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

    Widget buildSubstitute(RecipeSubstituteModel substitute) {
      return Container(
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Column(
                  children: [
                    ListTile(
                        title: AppText(
                          text: substitute.name,
                          size: AppTextSize.normal,
                          color: AppColors.textColor,
                        ),
                        subtitle: AppText(
                            color: AppColors.subtitleText,
                            text: displayMeasurement(substitute.measurement),
                            fontStyle: FontStyle.italic,
                            size: AppTextSize.small)),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.02,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: substitute.tags.length,
                            itemBuilder: (context, index) {
                              return AppText(
                                  size: AppTextSize.verySmall,
                                  color: AppColors.subtitleText,
                                  text: index < substitute.tags.length - 1
                                      ? "${getTagString(context, substitute.tags[index])}, "
                                      : getTagString(
                                          context, substitute.tags[index]));
                            }))
                  ],
                )),
            substitute.substitutionPrecision != null &&
                    substitute.substitutionPrecision!.isNotEmpty
                ? IconButton(
                    onPressed: () => {
                          showSubstitutionPrecisions(
                              substitute.substitutionPrecision)
                        },
                    icon: const Icon(Icons.comment_outlined),
                    iconSize: 24,
                    color: AppColors.textColor)
                : const SizedBox.shrink(),
          ],
        ),
      );
    }

    Widget buildIngredient(RecipeIngredientModel ingredient) {
      return ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              selectedAvatar(0),
              Column(
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ListTile(
                            title: AppText(
                              text: ingredient.name,
                              size: AppTextSize.normal,
                              color: AppColors.textColor,
                            ),
                            subtitle: AppText(
                                color: AppColors.subtitleText,
                                text:
                                    displayMeasurement(ingredient.measurement),
                                fontStyle: FontStyle.italic,
                                size: AppTextSize.small),
                          )),
                      pantryAvatar(0),
                      groceryListAvatar(0),
                    ],
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.02,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ingredient.tags.length,
                          itemBuilder: (context, index) {
                            return AppText(
                                size: AppTextSize.verySmall,
                                color: AppColors.subtitleText,
                                text: index < ingredient.tags.length - 1
                                    ? "${getTagString(context, ingredient.tags[index])}, "
                                    : getTagString(
                                        context, ingredient.tags[index]));
                          }))
                ],
              ),
            ],
          ),
          iconColor: ingredient.substitutes.isEmpty
              ? AppColors.backgroundColor60
              : AppColors.textColor,
          collapsedIconColor: ingredient.substitutes.isEmpty
              ? AppColors.backgroundColor60
              : AppColors.textColor,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: ingredient.substitutes.length * 85,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: ingredient.substitutes.length,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        buildSubstitute(ingredient.substitutes[index]),
                      ]);
                    }))
          ]);
    }

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.recipe.ingredients.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Column(children: [
                buildIngredient(widget.recipe.ingredients[index]),
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
