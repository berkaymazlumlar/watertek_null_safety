part of 'exploration_bloc.dart';

abstract class ExplorationEvent extends Equatable {
  const ExplorationEvent();

  @override
  List<Object> get props => [];
}

class GetExplorationEvent extends ExplorationEvent {}

class AddExplorationEvent extends ExplorationEvent {
  final ApiExplorationData apiExplorationData;
  AddExplorationEvent({@required this.apiExplorationData});
}

class ClearExplorationEvent extends ExplorationEvent {}
