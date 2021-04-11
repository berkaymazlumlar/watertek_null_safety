import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/models/api_service_report.dart';
import 'package:teknoloji_kimya_servis/models/service_report.dart';
import 'package:teknoloji_kimya_servis/repositories/service_report_repository/service_report_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

part 'service_report_event.dart';

part 'service_report_state.dart';

class ServiceReportBloc extends Bloc<ServiceReportEvent, ServiceReportState> {
  ServiceReportBloc() : super(ServiceReportListInitialState());
  ServiceReportRepository _serviceReportRepository =
      locator<ServiceReportRepository>();

  @override
  Stream<ServiceReportState> mapEventToState(
    ServiceReportEvent event,
  ) async* {
    if (event is GetServiceReportListEvent) {
      try {
        final serviceReportList =
            await _serviceReportRepository.getServiceReport();
        if (serviceReportList.data == null) {
          yield ServiceReportListErrorState(error: "");
        } else {
          yield ServiceReportListLoadedState(
              serviceReportList: serviceReportList);
        }
      } catch (error) {
        yield ServiceReportListErrorState(error: "");
      }
    }
    if (event is ClearServiceReportListEvent) {
      yield ServiceReportListInitialState();
    }
  }
}
