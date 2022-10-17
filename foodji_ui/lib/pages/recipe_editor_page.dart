import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../misc/colors.dart';
import '../models/ingredient_model.dart';
import '../models/recipe_model.dart';
import '../widgets/app_text.dart';
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
          topLeft: Radius.circular(30), bottomRight: Radius.circular(30)));

  final _formKey = GlobalKey<FormState>();

  _updateRecipe() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _savedRecipe = _currentRecipe;
        BlocProvider.of<AppCubits>(context).updateRecipe(_savedRecipe);
        _formKey.currentState!.save();
      });
      return "Recipe updated"; // TODO : i10n
    }
    return "Form not valid"; // TODO : i10n
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      if (state is RecipeEditorState) {
        _savedRecipe = state.recipe;
        _currentRecipe = _savedRecipe;
        return Scaffold(
          appBar: _appBar(),
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('img/background-gradient.png'),
                    fit: BoxFit.fill)),
            child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  shrinkWrap: true,
                  children: [
                    ListTile(
                        shape: _tileShape,
                        title: Column(
                          children: [
                            _buildName(),
                            _buildDescription(),
                            _buildCategory(),
                            // _uploadImage(),
                          ],
                        )),
                    const SizedBox(height: 20),
                    _buildIngredients(),
                    const SizedBox(height: 20),
                    _buildSteps(),
                    const SizedBox(height: 200),
                    Positioned(
                      // TODO: remove after debug
                      top: MediaQuery.of(context).size.height * 0.2,
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: AppColors.highlightColor2,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: AppText(text: _currentRecipe.toText())),
                    ),
                  ],
                )),
          ),
        );
      } else {
        return const ErrorPage();
      }
    });
  }

  _appBar() {
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
                  onPressed: () {
                    // TODO : fix Discard notification
                    // if (_currentRecipe != _savedRecipe) {
                    //   showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return AlertDialog(
                    //           title: const AppText(text: 'Discard changes?'),
                    //           actions: [
                    //             TextButton(
                    //               child: const AppText(text: 'Cancel'),
                    //               onPressed: () {},
                    //             ),
                    //             TextButton(
                    //               child: const AppText(text: 'Discard'),
                    //               onPressed: () => _updateRecipe(),
                    //             ),
                    //           ],
                    //         );
                    //       });
                    // }
                    BlocProvider.of<AppCubits>(context)
                        .gotoRecipeDetails(_savedRecipe);
                  }))
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

  _buidService() {
    // TODO : implement
  }

  _uploadImage() {
    // TODO : implement
  }

  _buildIngredients() {
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

  Widget _ingredientBuilder(IngredientModel ingredient) {
    return ListTile(
      key: ValueKey(ingredient),
      autofocus: true,
      focusColor: AppColors.backgroundColor,
      tileColor: AppColors.backgroundColor60,
      shape: _tileShape,
      title: Column(
        children: [
          // name
          TextFormField(
              initialValue: ingredient.name,
              decoration: const InputDecoration(
                hintText: 'Name',
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
        ],
      ),
      trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () =>
              setState(() => _currentRecipe.ingredients.remove(ingredient))),
    );
  }

  _buildSteps() {
    return ExpansionTile(
      title: const Text('Steps'), // TODO : i10n
      children: [
        // TODO : ReorderableListView
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _currentRecipe.steps.length,
          itemBuilder: (context, index) {
            return _stepBuilder(_currentRecipe.steps[index]);
          },
          // onReorder: (oldIndex, newIndex) {
          //   setState(() {
          //     if (newIndex > oldIndex) {
          //       newIndex -= 1;
          //     }
          //     final item = _currentRecipe.steps.removeAt(oldIndex);
          //     _currentRecipe.steps.insert(newIndex, item);
          //   });
          // },
        ),
        ElevatedButton(
          onPressed: () => setState(() => _currentRecipe.steps.add('')),
          child: const AppText(text: 'Add Step'), // TODO : i10n
        ),
      ],
    );
  }

  _stepBuilder(String stepName) {
    return ListTile(
      key: ValueKey(stepName),
      autofocus: true,
      focusColor: AppColors.backgroundColor,
      tileColor: AppColors.backgroundColor60,
      shape: _tileShape,
      title: TextFormField(
          initialValue: stepName,
          decoration: const InputDecoration(
            hintText: 'Step', // TODO : i10n
          ),
          maxLength: 300,
          minLines: 1,
          maxLines: 6,
          validator: (value) => (value == null || value.isEmpty)
              ? 'Please enter some text' // TODO : i10n
              : null,
          onSaved: (value) => stepName = value!),
      trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () =>
              setState(() => _currentRecipe.steps.remove(stepName))),
    );
  }
}
