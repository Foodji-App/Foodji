import 'package:flutter/material.dart';
import 'package:foodji_ui/pages/detailed_recipe_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodji',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const DetailedRecipePage()
      // home: BlocProvider<AppCubits>(
      //     create: (context) => AppCubits(data: DataServices()),
      //     child: const AppCubitLogics()),
    );
  }
}
