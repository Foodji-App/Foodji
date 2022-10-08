import 'package:flutter/material.dart';

import '../misc/colors.dart';
import '../models/recipe_model.dart';
import '../widgets/app_text.dart';

class RecipeEditorPage extends StatefulWidget {
  const RecipeEditorPage({Key? key}) : super(key: key);

  @override
  _RecipeEditorPageState createState() => _RecipeEditorPageState();
}

class _RecipeEditorPageState extends State<RecipeEditorPage> {
  late RecipeModel _recipe = RecipeModel.newRecipeModel();

  final _formKey = GlobalKey<FormState>();

  _buildName() {
    return TextFormField(
      initialValue: _recipe.name,
      decoration: InputDecoration(labelText: 'Name'),
      maxLength: 100,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        _recipe.name = value!;
      },
    );
  }

  _buildDescription() {
    return TextFormField(
      initialValue: _recipe.desc,
      decoration: InputDecoration(labelText: 'Description'),
      maxLength: 100,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Description is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        _recipe.desc = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(title: const AppText(text: 'Recipe Editor')),
        body: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: AppColors.highlightColor2,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: AppText(text: _recipe.toText())),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 20, right: 20),
              child: Form(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildName(),
                  _buildDescription(),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    child: const AppText(text: 'Submit'),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a Snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')));
                      }
                    },
                  ),
                ],
              )),
            ),
            const SizedBox(height: 30),
          ],
        ));
  }
}
