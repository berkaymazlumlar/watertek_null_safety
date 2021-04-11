part of 'work_order_list_bloc.dart';

abstract class WorkOrderListState extends Equatable {
  const WorkOrderListState();
}

class WorkOrderListInitialState extends WorkOrderListState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WorkOrderListLoadingState extends WorkOrderListState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WorkOrderListLoadedState extends WorkOrderListState {
  final ApiWorkOrder workOrderList;
  WorkOrderListLoadedState({@required this.workOrderList});

  @override
  List<Object> get props => [workOrderList];
}

class WorkOrderListErrorState extends WorkOrderListState {
  final String error;

  WorkOrderListErrorState({@required this.error});

  @override
  List<Object> get props => [error];
}
