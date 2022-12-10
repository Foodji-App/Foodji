import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/misc/app_util.dart';
import 'package:foodji_ui/models/categories_enum.dart';
import 'package:foodji_ui/models/recipe_ingredient_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../misc/colors.dart';
import '../misc/translation_util.dart';
import '../models/recipe_model.dart';
import '../widgets/app_text.dart';
import '../widgets/recipe_form/app_reorderable_text_form_fields.dart';
import 'error_page.dart';

class RecipeEditorPage extends StatefulWidget {
  const RecipeEditorPage({Key? key}) : super(key: key);

  @override
  RecipeEditorPageState createState() => RecipeEditorPageState();
}

class RecipeEditorPageState extends State<RecipeEditorPage>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  late RecipeModel _currentRecipe, _savedRecipe;
  late bool isFirstBuild = true;
  late AppLocalizations l10n;

  _updateRecipe() async {
    http.Response res;
    if (_formKey.currentState!.validate()) {
      if (_currentRecipe.id == null || _currentRecipe.id!.isEmpty) {
        res = await BlocProvider.of<AppCubits>(context)
            .createRecipe(_currentRecipe);
      } else {
        res = await BlocProvider.of<AppCubits>(context)
            .updateRecipe(_currentRecipe);
      }

      if (res.statusCode == 201) {
        setState(() {
          _savedRecipe = RecipeModel.deepCopy(_currentRecipe);
          _formKey.currentState!.save();
        });
        return l10n.form_recipe_updated;
      }
      return l10n.form_error;
    }
  }

  _deleteRecipe() {
    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return AlertDialog(
            title: AppText(text: l10n.global_form_delete_message),
            actions: [
              TextButton(
                child: AppText(text: l10n.global_form_cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: AppText(text: l10n.global_form_delete),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    http.Response res =
                        await BlocProvider.of<AppCubits>(context)
                            .deleteRecipe(_currentRecipe);
                    if (res.statusCode == 204) {
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<AppCubits>(context).gotoRecipes();
                    }
                  }),
            ],
          );
        });
  }

  _discardRecipe() {
    if (_currentRecipe.id == "" || _savedRecipe.id == "") {
      return BlocProvider.of<AppCubits>(context).gotoRecipes();
    } else if (!_savedRecipe.equals(_currentRecipe)) {
      showDialog(
          context: context,
          builder: (BuildContext context2) {
            return AlertDialog(
              title: AppText(text: l10n.global_form_discard_message),
              actions: [
                TextButton(
                  child: AppText(text: l10n.global_form_cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                    child: AppText(text: l10n.global_form_discard),
                    onPressed: () {
                      Navigator.of(context).pop();
                      BlocProvider.of<AppCubits>(context)
                          .gotoRecipeDetails(_savedRecipe);
                    }),
              ],
            );
          });
    } else {
      return BlocProvider.of<AppCubits>(context)
          .gotoRecipeDetails(_savedRecipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;

    // Build a Form widget using the _formKey created above.
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      if (state is RecipeEditorState) {
        if (isFirstBuild) {
          _savedRecipe = state.recipe;
          _currentRecipe = RecipeModel.deepCopy(_savedRecipe);
          isFirstBuild = false;
        }
        return Scaffold(
          appBar: _appBar(),
          body: Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('img/background-gradient.png'),
                        fit: BoxFit.fill)),
              ),
              SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Material(
                            shape: AppUtil.fullTile,
                            color: AppColors.backgroundColor,
                            child: ListTile(
                                title: Column(
                              children: [
                                _buildName(),
                                _buildDescription(),
                                Row(
                                  children: [
                                    Expanded(flex: 2, child: _buildCategory()),
                                    const SizedBox(width: 15),
                                    Expanded(flex: 1, child: _buildServes()),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            )),
                          ),
                          const SizedBox(height: 12),
                          _buildIngredients(),
                          const SizedBox(height: 12),
                          _buildSteps(),
                          const SizedBox(height: 20),
                        ],
                      )),
                ),
              ),
            ],
          ),
        );
      } else {
        return const ErrorPage();
      }
    });
  }

  AppBar _appBar() {
    return AppBar(
        title: AppText(
            text: l10n.form_recipe_title, color: AppColors.backgroundColor),
        backgroundColor: AppColors.textColor,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () async => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(await _updateRecipe())))),
          _currentRecipe.id != ""
              ? IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async => ScaffoldMessenger.of(context)
                      .showSnackBar(
                          SnackBar(content: Text(await _deleteRecipe()))))
              : Container(),
          Container(
              margin: const EdgeInsets.only(right: 4),
              child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: AppColors.backgroundColor,
                  onPressed: () => _discardRecipe()))
        ]);
  }

  Widget _buildName() {
    return TextFormField(
      initialValue: _currentRecipe.name,
      decoration: InputDecoration(hintText: l10n.recipe_name),
      maxLength: 50,
      validator: (String? value) => (value!.isEmpty)
          ? '${l10n.recipe_name} ${l10n.form_is_required}'
          : null,
      onChanged: (String? value) => _currentRecipe.name = value!,
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      initialValue: _currentRecipe.description,
      decoration: InputDecoration(hintText: l10n.recipe_description),
      maxLength: 300,
      minLines: 1,
      maxLines: 6,
      validator: (String? value) => (value!.isEmpty)
          ? '${l10n.recipe_description} ${l10n.form_is_required}'
          : null,
      onChanged: (String? value) => _currentRecipe.description = value!,
    );
  }

  Widget _buildCategory() {
    return DropdownButtonFormField<String>(
      value: _currentRecipe.category,
      decoration: InputDecoration(hintText: l10n.category),
      items: Categories.values.map<DropdownMenuItem<String>>((element) {
        return DropdownMenuItem<String>(
          value: element.name,
          child: Text(TranslationUtil.getCategoryString(context, element.name)),
        );
      }).toList(),
      onChanged: (String? value) =>
          setState(() => _currentRecipe.category = value!),
    );
  }

  Widget _buildServes() {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: _currentRecipe.details.serves.toString(),
      decoration: InputDecoration(hintText: l10n.recipe_servings),
      validator: (String? value) => (value!.isEmpty)
          ? '${l10n.recipe_servings} ${l10n.form_is_required}'
          : null,
      onChanged: (String? value) =>
          _currentRecipe.details.serves = int.parse(value!),
    );
  }

  Widget _buildSteps() {
    return Material(
      color: AppColors.backgroundColor,
      shape: AppUtil.fullTile,
      child: ExpansionTile(
        title: AppText(text: l10n.recipe_steps),
        children: [
          ReorderableTextFormFields(
            key: UniqueKey(),
            scrollController: _scrollController,
            items: _currentRecipe.steps,
            newItem: '',
            hintText: l10n.recipe_step,
            onChanged: (items) => _currentRecipe.steps = items,
            validator: (value) => (value == null || value.isEmpty)
                ? '${l10n.recipe_steps} ${l10n.form_is_required}'
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildIngredients() {
    return Material(
      color: AppColors.backgroundColor,
      shape: AppUtil.fullTile,
      child: ExpansionTile(
        title: AppText(text: l10n.recipe_ingredients),
        children: [
          ReorderableTextFormFields(
            key: UniqueKey(),
            scrollController: _scrollController,
            items: _currentRecipe.ingredients,
            newItem: RecipeIngredientModel.newRecipeIngredientModel(),
            hasCustomListTile: true,
            custombuildTenableListTile: (item) => _ingredientBuilder(item),
            onChanged: (items) =>
                setState(() => _currentRecipe.ingredients = items),
            validator: (value) => (value == null || value.isEmpty)
                ? '${l10n.recipe_ingredient} ${l10n.form_is_required}'
                : null,
          ),
        ],
      ),
    );
  }

  Widget _ingredientBuilder(int index) {
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (direction) =>
          Future.value(direction == DismissDirection.endToStart),
      onDismissed: (direction) {
        setState(() => _currentRecipe.ingredients.removeAt(index));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.form_item_dismissed)));
      },
      background: Container(color: Colors.red),
      child: ListTile(
        key: UniqueKey(),
        title: Column(
          children: [
            // name
            TextFormField(
                initialValue: _currentRecipe.ingredients[index].name,
                decoration: InputDecoration(
                  hintText: l10n.recipe_ingredient,
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? '${l10n.recipe_ingredient} ${l10n.form_is_required}'
                    : null,
                onChanged: (value) =>
                    _currentRecipe.ingredients[index].name = value),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // amount
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                                keyboardType: TextInputType.number,
                                initialValue: _currentRecipe
                                    .ingredients[index].measurement.value
                                    .toString(),
                                decoration: InputDecoration(
                                  hintText: l10n.recipe_amount,
                                ),
                                validator: (value) => (value == null ||
                                        value.isEmpty)
                                    ? '${l10n.recipe_amount} ${l10n.form_is_required}'
                                    : null,
                                onChanged: (value) => _currentRecipe
                                    .ingredients[index]
                                    .measurement
                                    .value = int.parse(value)),
                          ),
                          const SizedBox(width: 15),
                          // unit
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                                initialValue: _currentRecipe
                                    .ingredients[index].measurement.unitType,
                                decoration: InputDecoration(
                                  hintText: l10n.recipe_amount,
                                ),
                                validator: (value) => (value == null ||
                                        value.isEmpty)
                                    ? '${l10n.recipe_amount} ${l10n.form_is_required}'
                                    : null,
                                onChanged: (value) => _currentRecipe
                                    .ingredients[index]
                                    .measurement
                                    .unitType = value),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  child: Text(l10n.form_recipe_ingredient_substitute_add),
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        trailing: const Icon(Icons.drag_handle),
      ),
    );
  }
}
