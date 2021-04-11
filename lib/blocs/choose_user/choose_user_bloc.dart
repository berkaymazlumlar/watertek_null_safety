import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/api/get_apis.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';

part 'choose_user_event.dart';
part 'choose_user_state.dart';

class ChooseUserBloc extends Bloc<ChooseUserEvent, ChooseUserState> {
  ChooseUserBloc() : super(ChooseUserInitialState());

  @override
  Stream<ChooseUserState> mapEventToState(
    ChooseUserEvent event,
  ) async* {
    if (event is GetChooseUserEvent) {
      try {
        final _userList = await GetApi.getCustomerList();
        yield ChooseUserLoadedState(userList: _userList);
      } catch (e) {
        yield ChooseUserErrorState(error: "$e");
      }
    }
    if (event is ClearChooseUserEvent) {
      yield ChooseUserInitialState();
    }
  }
}
