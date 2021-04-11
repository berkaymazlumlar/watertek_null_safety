part of 'choose_user_bloc.dart';

abstract class ChooseUserEvent extends Equatable {
  const ChooseUserEvent();

  @override
  List<Object> get props => [];
}

class GetChooseUserEvent extends ChooseUserEvent {}

class ClearChooseUserEvent extends ChooseUserEvent {}
