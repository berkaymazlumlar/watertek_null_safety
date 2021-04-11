import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';
import 'package:teknoloji_kimya_servis/repositories/user_repository/user_list_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(UserListInitialState());
  final UserListRepository _userListRepository = locator<UserListRepository>();

  @override
  Stream<UserListState> mapEventToState(
    UserListEvent event,
  ) async* {
    if (event is GetUserListEvent) {
      try {
        final _userList = await _userListRepository.getApiUsers();
        yield UserListLoadedState(userList: _userList);
      } catch (e) {
        yield UserListErrorState(error: "$e");
      }
    }
    if (event is SearchUserListEvent) {
      print("tryın üstü");
      try {
        yield UserListLoadingState();

        final userList =
            await _userListRepository.getApiUsers(search: event.search);
        print(userList.body.first.fullName);
        yield UserListLoadedState(userList: userList);
      } catch (error) {
        yield UserListErrorState(error: error.toString());
      }
    }
    if (event is ClearUserListEvent) {
      yield UserListInitialState();
    }
  }
}
