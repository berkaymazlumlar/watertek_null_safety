part of 'user_location_list_bloc.dart';

abstract class UserLocationListState extends Equatable {
  const UserLocationListState();

  @override
  List<Object> get props => [];
}

class UserLocationListInitialState extends UserLocationListState {}

class UserLocationListSuccessState extends UserLocationListState {
  final List<UserLocationList> userLocationList;
  UserLocationListSuccessState({@required this.userLocationList});
}

class UserLocationListFailureState extends UserLocationListState {
  final String error;
  UserLocationListFailureState({@required this.error});
}
