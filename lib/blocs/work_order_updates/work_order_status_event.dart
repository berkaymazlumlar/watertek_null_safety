part of 'work_order_status_bloc.dart';

abstract class WorkOrderStatusEvent extends Equatable {
  const WorkOrderStatusEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetWorkOrderStatusEvent extends WorkOrderStatusEvent {
  final String workOrderId;

  GetWorkOrderStatusEvent({@required this.workOrderId});
}

class ClearWorkOrderStatusEvent extends WorkOrderStatusEvent {}
