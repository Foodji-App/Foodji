import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodji_ui/models/recipe_model.dart';

import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../misc/colors.dart';
import '../widgets/app_text.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({Key? key}) : super(key: key);

  @override
  RecipesPageState createState() => RecipesPageState();
}

class RecipesPageState extends State<RecipesPage> {
  TextEditingController searchBoxController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      if (state is AuthentifiedState) {
        List<RecipeModel> filteredRecipes = state.filteredRecipes;
        List<RecipeModel> recipes = state.recipes;

        void filterSearchResults(String query) {
          if (query.isNotEmpty) {
            List<RecipeModel> foundRecipes = [];
            for (var recipe in recipes) {
              if (recipe.name.toLowerCase().contains(query.toLowerCase()) ||
                  recipe.category.toLowerCase().contains(query.toLowerCase())) {
                foundRecipes.add(recipe);
              }
            }
            setState(() {
              filteredRecipes.clear();
              filteredRecipes.addAll(foundRecipes);
            });
            return;
          } else {
            setState(() {
              filteredRecipes.clear();
              filteredRecipes.addAll(recipes);
            });
          }
        }

        return Scaffold(
            body: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('img/background-gradient.png'),
                        fit: BoxFit.fill)),
                alignment: Alignment.center,
                child: Column(children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 2, bottom: 10, left: 0, right: 0),
                      child: Material(
                        color: AppColors.backgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        child: TextField(
                          onChanged: (value) {
                            filterSearchResults(value);
                          },
                          controller: searchBoxController,
                          decoration: InputDecoration(
                              focusColor: AppColors.highlightColor3,
                              labelText:
                                  AppLocalizations.of(context)!.global_filter,
                              hintText:
                                  AppLocalizations.of(context)!.global_filter,
                              prefixIcon: const Icon(Icons.search),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                        ),
                      )),
                  Expanded(
                      child: ListView.builder(
                    itemCount: filteredRecipes.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Material(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                              //Material required to solve known issue, see https://github.com/flutter/flutter/issues/83108
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                tileColor: AppColors.backgroundColor,
                                leading: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    height:
                                        MediaQuery.of(context).size.width / 6,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.textColor,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                filteredRecipes[index].img),
                                            fit: BoxFit.fitWidth))),
                                title: Text(filteredRecipes[index].name),
                                subtitle: Text(filteredRecipes[index].category),
                                isThreeLine: true,
                              )));
                    },
                  ))
                ])));
      } else {
        return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
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
        });
      }
    });
  }
}
