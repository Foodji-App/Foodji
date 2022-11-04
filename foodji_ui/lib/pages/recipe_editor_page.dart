import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/models/recipe_ingredient_model.dart';

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
      return "Recipe updated"; // TODO : i10n
    }
    return "Form not valid"; // TODO : i10n
  }

  _discardRecipe() {
    // TODO : fix Discard notification
    if (!_savedRecipe.equals(_currentRecipe)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const AppText(text: 'Discard changes?'),
              actions: [
                TextButton(
                  child: const AppText(text: 'Cancel'),
                  onPressed: () {},
                ),
                TextButton(
                  child: const AppText(text: 'Discard'),
                  onPressed: () => BlocProvider.of<AppCubits>(context)
                      .gotoRecipeDetails(_savedRecipe),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: const AppText(
            text: 'Recipe Editor',
            color: AppColors.backgroundColor), // TODO : i10n
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
                onPressed: () => BlocProvider.of<AppCubits>(context)
                    .gotoRecipeDetails(_savedRecipe),
                // TODO: Use _discardRecipe() after fixing rendering bugs,
              ))
        ]);
  }

  Widget _buildName() {
    return TextFormField(
      initialValue: _currentRecipe.name,
      decoration: const InputDecoration(hintText: 'Name'), // TODO : i10n
      maxLength: 50,
      validator: (String? value) =>
          (value!.isEmpty) ? 'Name is Required' : null,
      onSaved: (String? value) => _currentRecipe.name = value!,
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      initialValue: _currentRecipe.description,
      decoration: const InputDecoration(hintText: 'Description'), // TODO : i10n
      maxLength: 300,
      minLines: 1,
      maxLines: 6,
      validator: (String? value) =>
          (value!.isEmpty) ? 'Name is Required' : null, // TODO : i10n
      onSaved: (String? value) => _currentRecipe.description = value!,
    );
  }

  Widget _buildCategory() {
    // TODO : get from DB
    !_dropdownValues.contains(_currentRecipe.category)
        ? _dropdownValues.add(_currentRecipe.category)
        : null;

    return DropdownButtonFormField<String>(
      value: _currentRecipe.category,
      decoration: const InputDecoration(hintText: 'Category'), // TODO : i10n
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
    // TODO : implement
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: _currentRecipe.details.serves.toString(),
      decoration: const InputDecoration(hintText: 'Serves'), // TODO : i10n
      validator: (String? value) =>
          (value!.isEmpty) ? 'Name is Required' : null, // TODO : i10n
      onSaved: (String? value) =>
          _currentRecipe.details.serves = int.parse(value!),
    );
  }

  Widget _buildSteps() {
    return Material(
      color: AppColors.backgroundColor,
      shape: _tileShape,
      child: ExpansionTile(
        title: const AppText(text: 'Steps'),
        children: [
          ReorderableTextFormFields(
            key: ValueKey('${_currentRecipe.id}.steps'),
            color: AppColors.highlightColor2,
            scrollController: _scrollController,
            items: _currentRecipe.steps,
            newItem: '',
            onChanged: (items) => _currentRecipe.steps = items,
            validator: (value) => (value == null || value.isEmpty)
                ? 'Please enter some text' // TODO : i10n
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
        title: const AppText(text: 'Ingredients'),
        children: [
          ReorderableTextFormFields(
            key: ValueKey('${_currentRecipe.id}.ingredients'),
            color: AppColors.highlightColor3,
            scrollController: _scrollController,
            items: _currentRecipe.ingredients,
            newItem: RecipeIngredientModel.newRecipeIngredientModel(),
            hasCustomListTile: true,
            custombuildTenableListTile: (item) => _ingredientBuilder(item),
            onChanged: (items) => _currentRecipe.ingredients = items,
            validator: (value) => (value == null || value.isEmpty)
                ? 'Please enter some text' // TODO : i10n
                : null,
          ),
        ],
      ),
    );
  }

  ListTile _ingredientBuilder(int index) {
    return ListTile(
      key: ValueKey("ingredient-$_currentRecipe.ingredients[index]"),
      leading: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () =>
              setState(() => _currentRecipe.ingredients.removeAt(index))),
      title: Column(
        children: [
          // name
          TextFormField(
              initialValue: _currentRecipe.ingredients[index].name,
              decoration: const InputDecoration(
                hintText: 'Ingredient',
              ),
              validator: (value) => (value == null || value.isEmpty)
                  ? 'Please enter some text' // TODO : i10n
                  : null,
              onSaved: (value) =>
                  _currentRecipe.ingredients[index].name = value!),
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
                              decoration: const InputDecoration(
                                hintText: 'Amount', // TODO : i10n
                              ),
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                      ? 'Please enter some text' // TODO : i10n
                                      : null,
                              onSaved: (value) => _currentRecipe
                                  .ingredients[index]
                                  .measurement
                                  .value = int.parse(value!)),
                        ),
                        const SizedBox(width: 15),
                        // unit
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                              initialValue: _currentRecipe
                                  .ingredients[index].measurement.unitType,
                              decoration: const InputDecoration(
                                hintText: 'Unit', // TODO : i10n
                              ),
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                      ? 'Please enter some text' // TODO : i10n
                                      : null,
                              onSaved: (value) => _currentRecipe
                                  .ingredients[index]
                                  .measurement
                                  .unitType = value!),
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
    );
  }
}
