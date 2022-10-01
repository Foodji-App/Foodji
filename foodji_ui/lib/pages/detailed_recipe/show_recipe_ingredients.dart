// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../models/ingredient_model.dart';
import '../../widgets/app_text.dart';

class ShowRecipeIngredients extends StatelessWidget {
  List<IngredientModel> ingredients;

  ShowRecipeIngredients({Key? key, required this.ingredients})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Center(
      child: const AppText(
          text:
              "One fish, two fish, tree fish... I'm breaking up with you B*tch"),
    );
  }
}
