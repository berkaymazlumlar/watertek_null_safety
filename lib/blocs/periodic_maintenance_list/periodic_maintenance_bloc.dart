import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/models/api_periodic_maintenance.dart';
import 'package:teknoloji_kimya_servis/models/periodic_maintenance.dart';
import 'package:teknoloji_kimya_servis/repositories/periodic_maintenance/periodic_maintenance.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

part 'periodic_maintenance_event.dart';

part 'periodic_maintenance_state.dart';

class PeriodicMaintenanceBloc
    extends Bloc<PeriodicMaintenanceEvent, PeriodicMaintenanceState> {
  PeriodicMaintenanceBloc() : super(PeriodicMaintenanceListInitialState());
  final _periodicMaintenanceRepository =
      locator<PeriodicMaintenanceRepository>();

  @override
  Stream<PeriodicMaintenanceState> mapEventToState(
    PeriodicMaintenanceEvent event,
  ) async* {
    if (event is GetPeriodicMaintenanceListEvent) {
      try {
        final myPeriodicMaintenanceList =
            await _periodicMaintenanceRepository.getPeriodicMaintenance(
          customerId: event.customerId,
        );
        print(myPeriodicMaintenanceList.body.first.firstPeriodDate);
        yield PeriodicMaintenanceListLoadedState(
            periodicMaintenanceList: myPeriodicMaintenanceList);
      } catch (error) {
        yield PeriodicMaintenanceListErrorState(error: "");
      }
    }
    if (event is SearchPeriodicMaintenanceListEvent) {
      print("tryın üstü");
      try {
        yield PeriodicMaintenanceListLoadingState();

        final periodicMaintenanceList =
            await _periodicMaintenanceRepository.getPeriodicMaintenance(
          search: event.search,
          customerId: event.customerId,
        );
        print(periodicMaintenanceList.body.first.companyName);
        yield PeriodicMaintenanceListLoadedState(
            periodicMaintenanceList: periodicMaintenanceList);
      } catch (error) {
        yield PeriodicMaintenanceListErrorState(error: "");
      }
    }
    if (event is ClearPeriodicMaintenanceListEvent) {
      yield PeriodicMaintenanceListInitialState();
    }
  }
}
