import 'dart:js';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/categories_enum.dart';
import '../models/tags_enum.dart';
import '../models/unit_type_enum.dart';

class TranslationUtil {
  static String getCategoryString(context, category) {
    if (category == Categories.mainCourse.name) {
      return AppLocalizations.of(context)!.category_main_course;
    } else if (category == Categories.sideDish.name) {
      return AppLocalizations.of(context)!.category_side_dish;
    } else if (category == Categories.appetizer.name) {
      return AppLocalizations.of(context)!.category_appetizer;
    } else if (category == Categories.dessert.name) {
      return AppLocalizations.of(context)!.category_dessert;
    } else if (category == Categories.lunch.name) {
      return AppLocalizations.of(context)!.category_lunch;
    } else if (category == Categories.breakfast.name) {
      return AppLocalizations.of(context)!.category_breakfast;
    } else if (category == Categories.beverage.name) {
      return AppLocalizations.of(context)!.category_beverage;
    } else if (category == Categories.soup.name) {
      return AppLocalizations.of(context)!.category_soup;
    } else if (category == Categories.sauce.name) {
      return AppLocalizations.of(context)!.category_sauce;
    } else if (category == Categories.bread.name) {
      return AppLocalizations.of(context)!.category_bread;
    } else if (category == Categories.snack.name) {
      return AppLocalizations.of(context)!.category_snack;
    } else {
      return "";
    }
  }

  static String getTagString(context, tag) {
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

  static String getUnitTypeString(context, unitType) {
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
}
