part of 'work_order_list_bloc.dart';

abstract class WorkOrderListEvent extends Equatable {
  const WorkOrderListEvent();

  @override
  List<Object> get props => [];
}

class GetWorkOrderListEvent extends WorkOrderListEvent {
  final int workerId;

  GetWorkOrderListEvent({this.workerId});
}

class ClearWorkOrderListEvent extends WorkOrderListEvent {}

class SearchWorkOrderListEvent extends WorkOrderListEvent {
  final String search;
  SearchWorkOrderListEvent({@required this.search});
}
