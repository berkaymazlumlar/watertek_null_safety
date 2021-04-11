import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';
import 'package:teknoloji_kimya_servis/repositories/user_repository/user_list_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

part 'worker_list_event.dart';
part 'worker_list_state.dart';

class WorkerListBloc extends Bloc<WorkerListEvent, WorkerListState> {
  WorkerListBloc() : super(WorkerListInitialState());
  final UserListRepository _userListRepository = locator<UserListRepository>();

  @override
  Stream<WorkerListState> mapEventToState(
    WorkerListEvent event,
  ) async* {
    if (event is GetWorkerListEvent) {
      try {
        final _userList = await _userListRepository.getApiWorkers();
        yield WorkerListLoadedState(userList: _userList);
      } catch (e) {
        yield WorkerListErrorState(error: "$e");
      }
    }
    if (event is SearchWorkerListEvent) {
      print("tryın üstü");
      try {
        yield WorkerListLoadingState();

        final userList =
            await _userListRepository.getApiWorkers(search: event.search);
        print(userList.body.first.fullName);
        yield WorkerListLoadedState(userList: userList);
      } catch (error) {
        yield WorkerListErrorState(error: error.toString());
      }
    }
    if (event is ClearWorkerListEvent) {
      yield WorkerListInitialState();
    }
  }
}
