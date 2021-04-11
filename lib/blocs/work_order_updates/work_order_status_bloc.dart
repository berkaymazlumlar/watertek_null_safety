import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/models/work_order_status.dart';

part 'work_order_status_event.dart';
part 'work_order_status_state.dart';

class WorkOrderStatusBloc
    extends Bloc<WorkOrderStatusEvent, WorkOrderStatusState> {
  WorkOrderStatusBloc() : super(WorkOrderStatusInitialState());

  @override
  Stream<WorkOrderStatusState> mapEventToState(
    WorkOrderStatusEvent event,
  ) async* {
    if (event is GetWorkOrderStatusEvent) {
      try {
        var response = await FirebaseFirestore.instance
            .collection("work_order_status")
            .where("work_order_id", isEqualTo: event.workOrderId)
            .get();
        if (response.docs.length >= 0) {
          final List<WorkOrderStatus> workOrderStatusList = [];
          for (var doc in response.docs) {
            workOrderStatusList.add(
              WorkOrderStatus.fromJson(doc),
            );
          }
          workOrderStatusList.sort((first, second) {
            return first.createdAt.compareTo(second.createdAt) * -1;
          });

          yield WorkOrderStatusLoadedState(
              workOrderStatusList: workOrderStatusList);
        } else if (response.docs.length == 0) {
          yield WorkOrderStatusZeroState();
        } else {
          yield WorkOrderStatusErrorState(error: "Bir hata oluştu");
        }
      } on Exception catch (e) {
        yield WorkOrderStatusErrorState(
          error: e.toString(),
        );
      } finally {
        EralpHelper.stopProgress();
      }
    }
    if (event is ClearWorkOrderStatusEvent) {
      yield WorkOrderStatusInitialState();
    }
  }
}
