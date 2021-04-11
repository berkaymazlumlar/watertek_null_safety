part of 'periodic_maintenance_bloc.dart';

abstract class PeriodicMaintenanceEvent extends Equatable {
  const PeriodicMaintenanceEvent();
}

class GetPeriodicMaintenanceListEvent extends PeriodicMaintenanceEvent {
  final int customerId;
  GetPeriodicMaintenanceListEvent({this.customerId});

  @override
  List<Object> get props => [];
}

class SearchPeriodicMaintenanceListEvent extends PeriodicMaintenanceEvent {
  final String search;
  final int customerId;

  SearchPeriodicMaintenanceListEvent({
    @required this.search,
    this.customerId,
  });
  @override
  List<Object> get props => [];
}

class ClearPeriodicMaintenanceListEvent extends PeriodicMaintenanceEvent {
  @override
  List<Object> get props => [];
}
