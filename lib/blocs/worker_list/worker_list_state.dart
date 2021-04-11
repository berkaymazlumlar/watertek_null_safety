part of 'worker_list_bloc.dart';

abstract class WorkerListState extends Equatable {
  const WorkerListState();

  @override
  List<Object> get props => [];
}

class WorkerListInitialState extends WorkerListState {}

class WorkerListLoadedState extends WorkerListState {
  final ApiUsers userList;
  WorkerListLoadedState({@required this.userList});
}

class WorkerListLoadingState extends WorkerListState {}

class WorkerListErrorState extends WorkerListState {
  final String error;

  WorkerListErrorState({@required this.error});
}
