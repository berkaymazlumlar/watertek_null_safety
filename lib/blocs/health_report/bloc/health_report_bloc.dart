import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/models/api_health_report.dart';
import 'package:teknoloji_kimya_servis/repositories/health_report_repository/health_report.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

part 'health_report_event.dart';
part 'health_report_state.dart';

class HealthReportBloc extends Bloc<HealthReportEvent, HealthReportState> {
  HealthReportBloc() : super(HealthReportInitialState());
  final HealthReportRepository _healthReportRepository =
      locator<HealthReportRepository>();
  @override
  Stream<HealthReportState> mapEventToState(
    HealthReportEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is GetHealthReportEvent) {
      try {
        final _myHealthReports =
            await _healthReportRepository.getHealthReport();
        print(_myHealthReports);
        yield HealthReportLoadedState(apiHealthReport: _myHealthReports);
      } catch (e) {
        yield HealthReportErrorState(error: "$e");
      }
    }
    if (event is ClearHealthReportEvent) {
      yield HealthReportInitialState();
    }
  }
}
