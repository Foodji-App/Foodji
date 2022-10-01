import 'package:equatable/equatable.dart';

abstract class CubitStates extends Equatable {}

class InitialState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

class SplashState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

class LoadingState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

class LoadedState extends CubitStates {
  @override
  List<Object> get props => throw [];
}
