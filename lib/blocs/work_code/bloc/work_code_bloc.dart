import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/models/api_work_code.dart';
import 'package:teknoloji_kimya_servis/repositories/work_code/work_code_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
part 'work_code_event.dart';
part 'work_code_state.dart';

class WorkCodeBloc extends Bloc<WorkCodeEvent, WorkCodeState> {
  WorkCodeBloc() : super(WorkCodeInitialState());
  final WorkCodeRepository _workCodeRepository = locator<WorkCodeRepository>();
  @override
  Stream<WorkCodeState> mapEventToState(
    WorkCodeEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetWorkCodeEvent) {
      try {
        final _myWorkCodes = await _workCodeRepository.getWorkCode();
        print(_myWorkCodes);
        yield WorkCodeLoadedState(apiWorkCode: _myWorkCodes);
      } catch (e) {
        yield WorkCodeErrorState(error: "$e");
      }
    }
    if (event is ClearWorkCodeEvent) {
      yield WorkCodeInitialState();
    }
  }
}
