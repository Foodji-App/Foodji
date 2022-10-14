import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/services/data_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'cubit/app_cubit_logics.dart';
import 'cubit/app_cubits.dart';

void main() {
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
      theme: ThemeData(
          fontFamily: 'bauhaus'),
      debugShowCheckedModeBanner: false,
      scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<AppCubits>(
          create: (context) => AppCubits(data: DataServices()),
          child: const AppCubitLogics()),
    );
  }
}
