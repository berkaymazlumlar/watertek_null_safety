part of 'choose_user_bloc.dart';

abstract class ChooseUserState extends Equatable {
  const ChooseUserState();

  @override
  List<Object> get props => [];
}

class ChooseUserInitialState extends ChooseUserState {}

class ChooseUserLoadedState extends ChooseUserState {
  final ApiUsers userList;
  ChooseUserLoadedState({@required this.userList});
}

class ChooseUserErrorState extends ChooseUserState {
  final String error;

  ChooseUserErrorState({@required this.error});
}
