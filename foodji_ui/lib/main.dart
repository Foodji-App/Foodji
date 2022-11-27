import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/services/recipe_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'cubit/app_cubit_logics.dart';
import 'cubit/app_cubits.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);

  runApp(const MyApp());
}

class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateTitle: (context) =>
          AppLocalizations.of(context)!.global_app_name,
      theme: ThemeData(fontFamily: 'bauhaus'),
      debugShowCheckedModeBanner: false,
      scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<AppCubits>(
          create: (context) => AppCubits(recipeServices: RecipeServices()),
          child: const AppCubitLogics()),
    );
  }
}
