import 'package:equatable/equatable.dart';

abstract class CubitStates extends Equatable {}

class InitialState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

class LoadingState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

class AuthState extends CubitStates {
  @override
  List<Object> get props => throw [];
}

class ErrorState extends CubitStates {
  @override
  List<Object> get props => throw [];
}
