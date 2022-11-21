import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/misc/colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/app_globals.dart' as globals;
import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../widgets/app_text.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    globals.setActivePage(-1);
    var email = "";
    var password = "";
    bool error = false;

    register() async {
      bool res =
          await BlocProvider.of<AppCubits>(context).register(email, password);
      setState(() {
        error = res;
      });
    }

    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              body: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('img/background-gradient.png'),
                          fit: BoxFit.fill)),
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Material(
                                color: AppColors.backgroundColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(20.0)),
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(3),
                                      focusColor: AppColors.highlightColor3,
                                      hintText: AppLocalizations.of(context)!
                                          .authentification_email,
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight:
                                                  Radius.circular(20.0)))),
                                ))),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Material(
                                color: AppColors.backgroundColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(20.0)),
                                child: TextField(
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  obscureText: true,
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(3),
                                      focusColor: AppColors.highlightColor3,
                                      hintText: AppLocalizations.of(context)!
                                          .authentification_password,
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight:
                                                  Radius.circular(20.0)))),
                                ))),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Material(
                              color: AppColors.backgroundColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(20.0)),
                              child: TextButton(
                                  onPressed: () => register(),
                                  style: ButtonStyle(
                                    elevation: null,
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.backgroundColor),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.starColor1),
                                  ),
                                  child: AppText(
                                      text: AppLocalizations.of(context)!
                                          .authentification_register,
                                      color: AppColors.backgroundColor)),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Material(
                              color: Colors.red,
                              child: AppText(
                                  text: error
                                      ? AppLocalizations.of(context)!
                                          .registration_error
                                      : "",
                                  color: Colors.red)),
                        )
                      ]))));
    });
  }
}
