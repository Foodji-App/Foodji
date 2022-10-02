import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/data_services.dart';
import 'app_cubit_states.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data}) : super(InitialState()) {
    emit(LoadingState());
  }

  final DataServices data;

  //getters

  void getInitialData() async {
    try {
      emit(AuthState());
    } catch (e) {
      emit(ErrorState());
    }
  }

  //goto

  void gotoRecipes() async {
    try {
      emit(ErrorState());
    } catch (e) {
      emit(ErrorState());
    }
  }
}
