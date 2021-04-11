import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:teknoloji_kimya_servis/models/api_work_order.dart';
import 'package:teknoloji_kimya_servis/models/work_order.dart';
import 'package:teknoloji_kimya_servis/repositories/work_order_repository/work_order_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

part 'work_order_list_event.dart';

part 'work_order_list_state.dart';

class WorkOrderListBloc extends Bloc<WorkOrderListEvent, WorkOrderListState> {
  WorkOrderListBloc() : super(WorkOrderListInitialState());
  WorkOrderRepository _workOrderRepository = locator<WorkOrderRepository>();

  @override
  Stream<WorkOrderListState> mapEventToState(
    WorkOrderListEvent event,
  ) async* {
    if (event is GetWorkOrderListEvent) {
      print("tryın üstü");
      try {
        final workOrderList = await _workOrderRepository.getApiWorkOrder();
        yield WorkOrderListLoadingState();
        print(workOrderList.data.first.id);
        yield WorkOrderListLoadedState(workOrderList: workOrderList);
      } catch (error) {
        yield WorkOrderListErrorState(error: error.toString());
      }
    }
    if (event is SearchWorkOrderListEvent) {
      print("tryın üstü");
      try {
        yield WorkOrderListLoadingState();

        final workOrderList =
            await _workOrderRepository.getApiWorkOrder(search: event.search);
        print(workOrderList.data.first.companyName);
        yield WorkOrderListLoadedState(workOrderList: workOrderList);
      } catch (error) {
        yield WorkOrderListErrorState(error: error.toString());
      }
    }
    if (event is ClearWorkOrderListEvent) {
      yield WorkOrderListInitialState();
    }
  }
}
