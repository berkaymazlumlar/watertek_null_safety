part of 'worker_list_bloc.dart';

abstract class WorkerListEvent extends Equatable {
  const WorkerListEvent();

  @override
  List<Object> get props => [];
}

class GetWorkerListEvent extends WorkerListEvent {}

class ClearWorkerListEvent extends WorkerListEvent {}

class SearchWorkerListEvent extends WorkerListEvent {
  final String search;

  SearchWorkerListEvent({@required this.search});
}
