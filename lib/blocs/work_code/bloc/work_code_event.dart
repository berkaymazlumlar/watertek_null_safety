part of 'work_code_bloc.dart';

abstract class WorkCodeEvent extends Equatable {
  const WorkCodeEvent();

  @override
  List<Object> get props => [];
}

class GetWorkCodeEvent extends WorkCodeEvent {}

class ClearWorkCodeEvent extends WorkCodeEvent {}
