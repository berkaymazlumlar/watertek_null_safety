import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/api/get_apis.dart';
import 'package:teknoloji_kimya_servis/models/api_exploration.dart';

part 'exploration_event.dart';
part 'exploration_state.dart';

class ExplorationBloc extends Bloc<ExplorationEvent, ExplorationState> {
  ExplorationBloc() : super(ExplorationInitialState());

  @override
  Stream<ExplorationState> mapEventToState(
    ExplorationEvent event,
  ) async* {
    final _currentState = state;

    if (event is GetExplorationEvent) {
      try {
        final _response = await GetApi.getExplorationList();
        if (_response is ApiExploration) {
          yield ExplorationLoadedState(apiExploration: _response);
        } else {
          yield ExplorationErrorState(error: "$_response");
        }
      } catch (e) {
        yield ExplorationErrorState(error: "$e");
      }
    }
    if (event is ClearExplorationEvent) {
      yield ExplorationInitialState();
    }
    if (event is AddExplorationEvent) {
      if (_currentState is ExplorationLoadedState) {
        _currentState.addData([event.apiExplorationData]);
      }
    }
  }
}
