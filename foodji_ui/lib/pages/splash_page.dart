import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodji_ui/pages/auth_page.dart';

import '../cubit/app_globals.dart' as globals;
import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    // globals.setActivePage(-1);

    Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AuthPage()));
    });

    return Scaffold(
        body: BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('img/background-gradient.png'),
                  fit: BoxFit.fill)),
          child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.hardEdge,
              alignment: Alignment.centerLeft,
              children: [
                Positioned(
                  left: 0,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('img/background-bookmark.png'),
                            fit: BoxFit.fill),
                      )),
                ),
                Positioned(
                  left: 0,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "img/splash-${AppLocalizations.of(context)!.locale}.png"),
                            fit: BoxFit.fitWidth),
                      )),
                ),
              ]));
    }));
  }
}
