part of 'health_report_bloc.dart';

abstract class HealthReportEvent extends Equatable {
  const HealthReportEvent();

  @override
  List<Object> get props => [];
}

class GetHealthReportEvent extends HealthReportEvent {}

class ClearHealthReportEvent extends HealthReportEvent {}
