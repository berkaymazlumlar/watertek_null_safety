part of 'service_report_bloc.dart';

abstract class ServiceReportState extends Equatable {
  @override
  List<Object> get props => [];
  const ServiceReportState();
}

class ServiceReportListInitialState extends ServiceReportState {}

class ServiceReportListLoadingState extends ServiceReportState {}

class ServiceReportListLoadedState extends ServiceReportState {
  final ApiServiceReport serviceReportList;
  ServiceReportListLoadedState({@required this.serviceReportList});
}

class ServiceReportListErrorState extends ServiceReportState {
  final String error;
  ServiceReportListErrorState({@required this.error});
}
