part of 'user_list_bloc.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object> get props => [];
}

class UserListInitialState extends UserListState {}

class UserListLoadedState extends UserListState {
  final ApiUsers userList;
  UserListLoadedState({@required this.userList});
}

class UserListLoadingState extends UserListState {}

class UserListErrorState extends UserListState {
  final String error;

  UserListErrorState({@required this.error});
}
