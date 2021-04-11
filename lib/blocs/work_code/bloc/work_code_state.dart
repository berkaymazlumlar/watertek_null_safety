part of 'work_code_bloc.dart';

abstract class WorkCodeState extends Equatable {
  const WorkCodeState();

  @override
  List<Object> get props => [];
}

class WorkCodeInitialState extends WorkCodeState {}

class WorkCodeLoadedState extends WorkCodeState {
  final ApiWorkCode apiWorkCode;

  WorkCodeLoadedState({@required this.apiWorkCode});
}

class WorkCodeErrorState extends WorkCodeState {
  final String error;

  WorkCodeErrorState({@required this.error});
}
