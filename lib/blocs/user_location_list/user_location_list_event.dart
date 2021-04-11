part of 'user_location_list_bloc.dart';

abstract class UserLocationListEvent extends Equatable {
  const UserLocationListEvent();

  @override
  List<Object> get props => [];
}

class GetUserLocationListEvent extends UserLocationListEvent {}

class ClearUserLocationListEvent extends UserLocationListEvent {}
