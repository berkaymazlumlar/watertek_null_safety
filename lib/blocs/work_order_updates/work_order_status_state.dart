part of 'work_order_status_bloc.dart';

abstract class WorkOrderStatusState extends Equatable {
  const WorkOrderStatusState();

  @override
  List<Object> get props => [];
}

class WorkOrderStatusInitialState extends WorkOrderStatusState {}

class WorkOrderStatusLoadedState extends WorkOrderStatusState {
  final List<WorkOrderStatus> workOrderStatusList;

  WorkOrderStatusLoadedState({@required this.workOrderStatusList});
}

class WorkOrderStatusZeroState extends WorkOrderStatusState {}

class WorkOrderStatusErrorState extends WorkOrderStatusState {
  final String error;

  WorkOrderStatusErrorState({@required this.error});
}
