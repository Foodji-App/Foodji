import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/misc/colors.dart';

import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../widgets/app_text.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
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
                        BlocProvider.of<AppCubits>(context).gotoRecipes();
                      },
                      child: const AppText(
                          text: 'Cliquez pour accéder à la démo',
                          color: AppColors.backgroundColor,
                          size: AppTextSize.normal,
                          fontFamily: AppFontFamily.bauhaus)))));
    });
  }
}
