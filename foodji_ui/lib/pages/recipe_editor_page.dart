import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../misc/colors.dart';
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

  final _formKey = GlobalKey<FormState>();

  _updateRecipe() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        BlocProvider.of<AppCubits>(context).updateRecipe(_currentRecipe);
        _formKey.currentState!.save();
        _savedRecipe = _currentRecipe;
      });
      return "Recipe updated";
    }
    return "Form not valid";
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
          body: SizedBox.expand(
            child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  shrinkWrap: true,
                  children: [
                    _buildName(),
                    _buildDescription(),
                    _buildCategory(),
                    // _buildIngredients(),
                    // _buildSteps(),
                    // _uploadImage(),

                    const SizedBox(height: 300),
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

  _buildName() {
    return TextFormField(
      initialValue: _currentRecipe.name,
      decoration: const InputDecoration(labelText: 'Name'), // TODO : i10n
      maxLength: 50,
      validator: (String? value) =>
          (value!.isEmpty) ? 'Name is Required' : null,
      onSaved: (String? value) => _currentRecipe.name = value!,
    );
  }

  _buildDescription() {
    return TextFormField(
      initialValue: _currentRecipe.description,
      decoration:
          const InputDecoration(labelText: 'Description'), // TODO : i10n
      maxLength: 300,
      minLines: 1,
      maxLines: 6,
      validator: (String? value) =>
          (value!.isEmpty) ? 'Name is Required' : null,
      onSaved: (String? value) => _currentRecipe.description = value!,
    );
  }

  _buildCategory() {
    // TODO : get from DB
    var dropdownValues = <String>[
      'Breakfast',
      'Lunch',
      'Dinner',
      'Dessert',
      'Snack'
    ];
    !dropdownValues.contains(_currentRecipe.category)
        ? dropdownValues.add(_currentRecipe.category)
        : null;

    return DropdownButtonFormField<String>(
      value: _currentRecipe.category,
      decoration: const InputDecoration(labelText: 'Category'), // TODO : i10n
      items: dropdownValues.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: AppText(text: value),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          _currentRecipe.category = value!;
        });
      },
    );
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
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(_updateRecipe())));
              }),
          Container(
              margin: const EdgeInsets.only(right: 4),
              child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: AppColors.backgroundColor,
                  onPressed: () {
                    if (_currentRecipe != _savedRecipe) {
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
                    // else {
                    //   Navigator.of(context).pop();
                    // }
                  }))
        ]);
  }

  _buidService() {
    // TODO : implement
  }

  _buildSteps() {
    // TODO : implement
  }

  _buildIngredients() {
    // TODO : implement
  }
  _uploadImage() {
    // TODO : implement
  }
}
