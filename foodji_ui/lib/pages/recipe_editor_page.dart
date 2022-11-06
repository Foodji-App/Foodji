import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/models/recipe_ingredient_model.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../misc/colors.dart';
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
  late RecipeModel _currentRecipe, _savedRecipe;

  late AppLocalizations i10n;

  final _dropdownValues = <String>[
    'Breakfast',
    'Lunch',
    'Dinner',
    'Dessert',
    'Snack'
  ];

  final _tileShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), bottomRight: Radius.circular(15)));

  final _formKey = GlobalKey<FormState>();

  final _scrollController = ScrollController();

  _updateRecipe() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        // TODO : Send recipe to database
        // _savedRecipe = BlocProvider.....
        BlocProvider.of<AppCubits>(context)
            .updateRecipe(RecipeModel.deepCopy(_currentRecipe));
        _savedRecipe = RecipeModel.deepCopy(_currentRecipe);
        _formKey.currentState!.save();
      });
      return i10n.form_recipe_updated;
    }
    return i10n.form_error;
  }

  _discardRecipe() {
    if (!_savedRecipe.equals(_currentRecipe)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const AppText(text: 'Discard changes?'),
              actions: [
                TextButton(
                  child: const AppText(text: 'Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                    child: const AppText(text: 'Discard'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      BlocProvider.of<AppCubits>(context)
                          .gotoRecipeDetails(_savedRecipe);
                    }),
              ],
            );
          });
    } else {
      BlocProvider.of<AppCubits>(context).gotoRecipeDetails(_savedRecipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    i10n = AppLocalizations.of(context)!;

    // Build a Form widget using the _formKey created above.
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      if (state is RecipeEditorState) {
        _savedRecipe = state.recipe;
        _currentRecipe = RecipeModel.deepCopy(_savedRecipe);
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
                            shape: _tileShape,
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
            text: i10n.form_recipe_title, color: AppColors.backgroundColor),
        backgroundColor: AppColors.textColor,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(_updateRecipe())))),
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
      decoration: InputDecoration(hintText: i10n.recipe_name),
      maxLength: 50,
      validator: (String? value) => (value!.isEmpty)
          ? '${i10n.recipe_name} ${i10n.form_is_required}'
          : null,
      onChanged: (String? value) => _currentRecipe.name = value!,
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      initialValue: _currentRecipe.description,
      decoration: InputDecoration(hintText: i10n.recipe_description),
      maxLength: 300,
      minLines: 1,
      maxLines: 6,
      validator: (String? value) => (value!.isEmpty)
          ? '${i10n.recipe_description} ${i10n.form_is_required}'
          : null,
      onChanged: (String? value) => _currentRecipe.description = value!,
    );
  }

  Widget _buildCategory() {
    // TODO : get from DB
    !_dropdownValues.contains(_currentRecipe.category)
        ? _dropdownValues.add(_currentRecipe.category)
        : null;

    return DropdownButtonFormField<String>(
      value: _currentRecipe.category,
      decoration: InputDecoration(hintText: i10n.category),
      items: _dropdownValues.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
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
      decoration: InputDecoration(hintText: i10n.recipe_serves),
      validator: (String? value) => (value!.isEmpty)
          ? '${i10n.recipe_serves} ${i10n.form_is_required}'
          : null,
      onChanged: (String? value) =>
          _currentRecipe.details.serves = int.parse(value!),
    );
  }

  Widget _buildSteps() {
    return Material(
      color: AppColors.backgroundColor,
      shape: _tileShape,
      child: ExpansionTile(
        title: AppText(text: i10n.recipe_steps),
        children: [
          ReorderableTextFormFields(
            key: UniqueKey(),
            scrollController: _scrollController,
            items: _currentRecipe.steps,
            newItem: '',
            hintText: i10n.recipe_step,
            onChanged: (items) => _currentRecipe.steps = items,
            validator: (value) => (value == null || value.isEmpty)
                ? '${i10n.recipe_steps} ${i10n.form_is_required}'
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildIngredients() {
    return Material(
      color: AppColors.backgroundColor,
      shape: _tileShape,
      child: ExpansionTile(
        title: AppText(text: i10n.recipe_ingredients),
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
                ? '${i10n.recipe_ingredient} ${i10n.form_is_required}'
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
            .showSnackBar(SnackBar(content: Text(i10n.form_item_dismissed)));
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
                  hintText: i10n.recipe_ingredient,
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? '${i10n.recipe_ingredient} ${i10n.form_is_required}'
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
                                  hintText: i10n.recipe_amount,
                                ),
                                validator: (value) => (value == null ||
                                        value.isEmpty)
                                    ? '${i10n.recipe_amount} ${i10n.form_is_required}'
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
                                  hintText: i10n.recipe_amount,
                                ),
                                validator: (value) => (value == null ||
                                        value.isEmpty)
                                    ? '${i10n.recipe_amount} ${i10n.form_is_required}'
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
