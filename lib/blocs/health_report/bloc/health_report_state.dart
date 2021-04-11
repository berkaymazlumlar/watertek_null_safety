part of 'health_report_bloc.dart';

abstract class HealthReportState extends Equatable {
  const HealthReportState();

  @override
  List<Object> get props => [];
}

class HealthReportInitialState extends HealthReportState {}

class HealthReportLoadedState extends HealthReportState {
  final ApiHealthReport apiHealthReport;

  HealthReportLoadedState({@required this.apiHealthReport});
}

class HealthReportErrorState extends HealthReportState {
  final String error;

  HealthReportErrorState({@required this.error});
}
