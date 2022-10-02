import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/auth_page.dart';
import '../pages/error_page.dart';
import 'app_cubit_states.dart';
import 'app_cubits.dart';

import '../pages/splash_page.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({super.key});

  @override
  State<AppCubitLogics> createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      if (state is LoadingState) {
        return const SplashPage();
      } else if (state is AuthState) {
        return const AuthPage();
      } else if (state is ErrorState) {
        return const ErrorPage();
      } else {
        return Container();
      }
    }));
  }
}
