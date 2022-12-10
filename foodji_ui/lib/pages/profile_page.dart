import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutterfire_ui/i10n.dart';

import '../cubit/app_globals.dart' as globals;
import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    globals.setActivePage(3);
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      return MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            FlutterFireUILocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(fontFamily: 'bauhaus', brightness: Brightness.dark),
          debugShowCheckedModeBanner: false,
          home: ProfileScreen(actions: [
            SignedOutAction((context) {
              BlocProvider.of<AppCubits>(context).getInitialData();
            })
          ]));
    });
  }
}
