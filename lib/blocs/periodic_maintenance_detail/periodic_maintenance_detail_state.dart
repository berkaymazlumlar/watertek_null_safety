part of 'periodic_maintenance_detail_bloc.dart';

abstract class PeriodicMaintenanceDetailState extends Equatable {
  const PeriodicMaintenanceDetailState();

  @override
  List<Object> get props => [];
}

class PeriodicMaintenanceDetailInitial extends PeriodicMaintenanceDetailState {}

class PeriodicMaintenanceDetailLoaded extends PeriodicMaintenanceDetailState {
  final ApiPeriodicMaintenance apiPeriodicMaintenance;

  PeriodicMaintenanceDetailLoaded({@required this.apiPeriodicMaintenance});
}

class PeriodicMaintenanceDetailError extends PeriodicMaintenanceDetailState {}
