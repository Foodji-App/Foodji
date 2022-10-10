import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/widgets/app_text.dart';
import '../widgets/stateless_app_bar.dart' as stateless_app_bar_widget;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../misc/colors.dart';
import '../models/recipe_model.dart';

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({Key? key}) : super(key: key);

  @override
  RecipeDetailPageState createState() => RecipeDetailPageState();
}

class RecipeDetailPageState extends State<RecipeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      if (state is RecipeState) {
        RecipeModel recipe = state.recipe;
        return Scaffold(
            appBar: stateless_app_bar_widget.AppBar(
                AppLocalizations.of(context)!.app_bar_recipe_details),
            backgroundColor: AppColors.backgroundColor,
            body: CustomScrollView(slivers: [
              SliverAppBar(
                backgroundColor: AppColors.textColor,
                foregroundColor: AppColors.backgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.width * 0.35,
                        padding: const EdgeInsets.all(7),
                        child: Image(
                            image: NetworkImage(recipe.img),
                            width: MediaQuery.of(context).size.width))),
                title: Text(recipe.name, style: const TextStyle(fontSize: 14)),
                actions: [
                  IconButton(
                      icon: const Icon(Icons.edit_rounded),
                      color: AppColors.backgroundColor,
                      onPressed: () => {}),
                  Container(
                      margin: const EdgeInsets.only(right: 4),
                      child: IconButton(
                          icon: const Icon(Icons.arrow_back_rounded),
                          color: AppColors.backgroundColor,
                          onPressed: () => BlocProvider.of<AppCubits>(context)
                              .gotoRecipes()))
                ],
                pinned: true,
                expandedHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(height: 800, width: MediaQuery.of(context).size.width)
              ]))
            ]));
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
