import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/data_services.dart';
import 'app_cubit_states.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data}) : super(InitialState()) {
    emit(SplashState());
  }

  final DataServices data;

  void getData() async {
    try {
      emit(LoadingState());
      emit(LoadedState());
    } catch (e) {
      emit(LoadedState());
    }
  }
}
