import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/models/api_request.dart';
import 'package:teknoloji_kimya_servis/repositories/customer_request/customer_request_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

part 'customer_request_list_event.dart';
part 'customer_request_list_state.dart';

class CustomerRequestListBloc
    extends Bloc<CustomerRequestListEvent, CustomerRequestListState> {
  CustomerRequestListBloc() : super(CustomerRequestListInitialState());
  CustomerRequestRepository _customerRequestRepository =
      locator<CustomerRequestRepository>();

  @override
  Stream<CustomerRequestListState> mapEventToState(
    CustomerRequestListEvent event,
  ) async* {
    if (event is GetCustomerRequestListEvent) {
      try {
        final _requestList = await _customerRequestRepository
            .getCustomerRequest(customerId: event.customerId);

        yield CustomerRequestListLoadedState(
            apiCustomerRequestList: _requestList);
      } catch (e) {
        yield CustomerRequestListErrorState(
          error: e.toString(),
        );
      }
    }
    if (event is ClearCustomerRequestListEvent) {
      yield CustomerRequestListInitialState();
    }
  }
}
