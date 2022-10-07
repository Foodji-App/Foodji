import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/data_services.dart';
import 'app_cubit_states.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data}) : super(InitialState()) {
    emit(InitState());
  }

  final DataServices data;

  // Getters -------------------------------------

  // Splash screen
  void getInitialData() async {
    try {
      emit(AuthentificationRequestState());
    } catch (e) {
      emit(ErrorState());
    }
  }

  // Setters -------------------------------------

  // Navigation ----------------------------------

  // To user's recipes list through navigation bar display, once user has
  // been authorized to proceed
  void gotoAuthentifiedState() async {
    try {
      emit(AuthentifiedState());
    } catch (e) {
      emit(ErrorState());
    }
  }

  // To splash screen
  void gotoInit() async {
    try {
      emit(InitState());
    } catch (e) {
      emit(ErrorState());
    }
  }
}
