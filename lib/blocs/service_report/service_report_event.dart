part of 'service_report_bloc.dart';

abstract class ServiceReportEvent extends Equatable {
  @override
  List<Object> get props => [];

  const ServiceReportEvent();
}

class GetServiceReportListEvent extends ServiceReportEvent {}
class ClearServiceReportListEvent extends ServiceReportEvent {}