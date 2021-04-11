import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/api/get_apis.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_periodic_maintenance.dart';

part 'periodic_maintenance_detail_event.dart';
part 'periodic_maintenance_detail_state.dart';

class PeriodicMaintenanceDetailBloc extends Bloc<PeriodicMaintenanceDetailEvent,
    PeriodicMaintenanceDetailState> {
  PeriodicMaintenanceDetailBloc() : super(PeriodicMaintenanceDetailInitial());

  @override
  Stream<PeriodicMaintenanceDetailState> mapEventToState(
    PeriodicMaintenanceDetailEvent event,
  ) async* {
    if (event is GetPeriodicMaintenanceDetailEvent) {
      try {
        // EralpHelper.startProgress();
        final _response = await GetApi.getSpecificPeriodicMaintenance(event.id);
        if (_response is ApiPeriodicMaintenance) {
          yield PeriodicMaintenanceDetailLoaded(
              apiPeriodicMaintenance: _response);
        } else {
          yield PeriodicMaintenanceDetailError();
        }
      } catch (e) {
        print(e);
      } finally {
        // EralpHelper.stopProgress();
      }
    }
    if (event is ClearPeriodicMaintenanceDetailEvent) {
      yield PeriodicMaintenanceDetailInitial();
    }
  }
}
