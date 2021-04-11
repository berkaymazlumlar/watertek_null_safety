part of 'customer_list_bloc.dart';

abstract class CustomerListState extends Equatable {
  const CustomerListState();

  @override
  List<Object> get props => [];
}

class CustomerListInitialState extends CustomerListState {}

class CustomerListLoadedState extends CustomerListState {
  final ApiUsers userList;
  CustomerListLoadedState({@required this.userList});
}

class CustomerListLoadingState extends CustomerListState {}

class CustomerListErrorState extends CustomerListState {
  final String error;

  CustomerListErrorState({@required this.error});
}
