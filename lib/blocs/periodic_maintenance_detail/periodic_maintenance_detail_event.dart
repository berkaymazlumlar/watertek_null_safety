part of 'periodic_maintenance_detail_bloc.dart';

abstract class PeriodicMaintenanceDetailEvent extends Equatable {
  const PeriodicMaintenanceDetailEvent();

  @override
  List<Object> get props => [];
}

class GetPeriodicMaintenanceDetailEvent extends PeriodicMaintenanceDetailEvent {
  final String id;

  GetPeriodicMaintenanceDetailEvent({@required this.id});
}

class ClearPeriodicMaintenanceDetailEvent extends PeriodicMaintenanceDetailEvent {}
