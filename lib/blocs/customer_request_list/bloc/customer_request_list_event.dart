part of 'customer_request_list_bloc.dart';

abstract class CustomerRequestListEvent extends Equatable {
  const CustomerRequestListEvent();

  @override
  List<Object> get props => [];
}

class GetCustomerRequestListEvent extends CustomerRequestListEvent {
  final int customerId;
  GetCustomerRequestListEvent({this.customerId});
}

class ClearCustomerRequestListEvent extends CustomerRequestListEvent {}
