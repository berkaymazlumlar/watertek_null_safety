part of 'customer_request_list_bloc.dart';

abstract class CustomerRequestListState extends Equatable {
  const CustomerRequestListState();

  @override
  List<Object> get props => [];
}

class CustomerRequestListInitialState extends CustomerRequestListState {}

class CustomerRequestListLoadedState extends CustomerRequestListState {
  final ApiCustomerRequest apiCustomerRequestList;

  CustomerRequestListLoadedState({@required this.apiCustomerRequestList});
}

class CustomerRequestListErrorState extends CustomerRequestListState {
  final String error;

  CustomerRequestListErrorState({@required this.error});
}
