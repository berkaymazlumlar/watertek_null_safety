part of 'user_list_bloc.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object> get props => [];
}

class GetUserListEvent extends UserListEvent {}

class ClearUserListEvent extends UserListEvent {}

class SearchUserListEvent extends UserListEvent {
  final String search;

  SearchUserListEvent({@required this.search});
}
