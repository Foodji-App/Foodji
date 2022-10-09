import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/app_globals.dart' as globals;
import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';

class ExplorationPage extends StatefulWidget {
  const ExplorationPage({Key? key}) : super(key: key);

  @override
  ExplorationPageState createState() => ExplorationPageState();
}

class ExplorationPageState extends State<ExplorationPage> {
  @override
  Widget build(BuildContext context) {
    globals.setActivePage(2);
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      return Scaffold(
          body: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/background-gradient.png'),
                      fit: BoxFit.fill)),
              alignment: Alignment.center));
    });
  }
}
