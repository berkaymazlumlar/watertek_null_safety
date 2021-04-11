part of 'customer_list_bloc.dart';

abstract class CustomerListEvent extends Equatable {
  const CustomerListEvent();

  @override
  List<Object> get props => [];
}

class GetCustomerListEvent extends CustomerListEvent {}

class ClearCustomerListEvent extends CustomerListEvent {}

class SearchCustomerListEvent extends CustomerListEvent {
  final String search;

  SearchCustomerListEvent({@required this.search});
}
