part of 'exploration_bloc.dart';

abstract class ExplorationState extends Equatable {
  const ExplorationState();

  @override
  List<Object> get props => [];
}

class ExplorationInitialState extends ExplorationState {}

class ExplorationTempState extends ExplorationState {}

class ExplorationLoadedState extends ExplorationState {
  final ApiExploration apiExploration;
  ExplorationLoadedState({@required this.apiExploration});

  ExplorationLoadedState addData(List<ApiExplorationData> apiExplorationData) {
    return ExplorationLoadedState(
      apiExploration: ApiExploration(
        count: this.apiExploration.count + 1,
        body: this.apiExploration.body + apiExplorationData,
      ),
    );
  }
}

class ExplorationErrorState extends ExplorationState {
  final String error;
  ExplorationErrorState({@required this.error});
}
