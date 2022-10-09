import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/misc/colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/app_globals.dart' as globals;
import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../widgets/app_text.dart';

class AuthentificationPage extends StatefulWidget {
  const AuthentificationPage({Key? key}) : super(key: key);

  @override
  AuthentificationPageState createState() => AuthentificationPageState();
}

class AuthentificationPageState extends State<AuthentificationPage> {
  @override
  Widget build(BuildContext context) {
    globals.setActivePage(-1);
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      return Scaffold(
          body: GestureDetector(
              onTap: () => BlocProvider.of<AppCubits>(context).authentify(),
              child: Container(
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
                      child: AppText(
                          text: AppLocalizations.of(context)!.demo_access,
                          color: AppColors.backgroundColor,
                          size: AppTextSize.normal,
                          fontFamily: AppFontFamily.bauhaus)))));
    });
  }
}
