import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../misc/colors.dart';
import '../models/ingredient_model.dart';
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
        BlocProvider.of<AppCubits>(context).updateRecipe(_savedRecipe);
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
                  onPressed: () => _updateRecipe(),
                ),
              ],
            );
          });
    }
    BlocProvider.of<AppCubits>(context).gotoRecipeDetails(_savedRecipe);
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      if (state is RecipeEditorState) {
        _savedRecipe = RecipeModel.deepCopy(state.recipe);
        _currentRecipe = RecipeModel.deepCopy(_savedRecipe);
        return Scaffold(
          appBar: _appBar(),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 10, top: 12, right: 10, bottom: 14),
              width: double.maxFinite,
              height: double.maxFinite,
              // BUG : overflow le background des tiles
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/background-gradient.png'),
                      fit: BoxFit.fill)),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ListTile(
                          tileColor: AppColors.highlightColor1,
                          shape: _tileShape,
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
                      const SizedBox(height: 20),
                      // ingredients
                      _buildIngredients(),
                      // steps
                      Expanded(
                          child: ReorderableTextFormFields(
                        scrollController: _scrollController,
                        items: _currentRecipe.steps,
                        onChanged: (items) => _currentRecipe.steps = items,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Please enter some text' // TODO : i10n
                            : null,
                      )),
                      // _buildSteps(),
                      const SizedBox(height: 20),
                    ],
                  )),
            ),
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

  Widget _buildIngredients() {
    return ExpansionTile(
      title: const Text('Ingredients'), // TODO : i10n
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _currentRecipe.ingredients.length,
          itemBuilder: (context, index) {
            return _ingredientBuilder(_currentRecipe.ingredients[index]);
          },
        ),
        ElevatedButton(
          onPressed: () => setState(() => _currentRecipe.ingredients
              .add(IngredientModel.newIngredientModel())),
          child: const AppText(text: 'Add Ingredient'), // TODO : i10n
        ),
      ],
    );
  }

  ListTile _ingredientBuilder(IngredientModel ingredient) {
    return ListTile(
      key: ValueKey(ingredient),
      tileColor: AppColors.highlightColor3,
      shape: _tileShape,
      title: Column(
        children: [
          // name
          TextFormField(
              initialValue: ingredient.name,
              decoration: const InputDecoration(
                hintText: 'Ingredient',
              ),
              validator: (value) => (value == null || value.isEmpty)
                  ? 'Please enter some text' // TODO : i10n
                  : null,
              onSaved: (value) => ingredient.name = value!),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        // amount
                        Expanded(
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: ingredient.amount.toString(),
                              decoration: const InputDecoration(
                                hintText: 'Amount', // TODO : i10n
                              ),
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                      ? 'Please enter some text' // TODO : i10n
                                      : null,
                              onSaved: (value) =>
                                  ingredient.amount = int.parse(value!)),
                        ),
                        const SizedBox(width: 15),
                        // unit
                        Expanded(
                          child: TextFormField(
                              initialValue: ingredient.unit,
                              decoration: const InputDecoration(
                                hintText: 'Unit', // TODO : i10n
                              ),
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                      ? 'Please enter some text' // TODO : i10n
                                      : null,
                              onSaved: (value) => ingredient.unit = value!),
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
      trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () =>
              setState(() => _currentRecipe.ingredients.remove(ingredient))),
    );
  }
}
