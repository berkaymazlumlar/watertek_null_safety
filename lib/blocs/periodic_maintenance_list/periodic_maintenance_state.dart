part of 'periodic_maintenance_bloc.dart';

abstract class PeriodicMaintenanceState extends Equatable {
  const PeriodicMaintenanceState();
  @override
  List<Object> get props => [];
}

class PeriodicMaintenanceListInitialState extends PeriodicMaintenanceState {}

class PeriodicMaintenanceListLoadedState extends PeriodicMaintenanceState {
  final ApiPeriodicMaintenance periodicMaintenanceList;
  PeriodicMaintenanceListLoadedState({@required this.periodicMaintenanceList});
}

class PeriodicMaintenanceListLoadingState extends PeriodicMaintenanceState {}

class PeriodicMaintenanceListErrorState extends PeriodicMaintenanceState {
  final String error;

  PeriodicMaintenanceListErrorState({@required this.error});
}
