import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';
import 'package:teknoloji_kimya_servis/repositories/user_repository/user_list_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

part 'customer_list_event.dart';
part 'customer_list_state.dart';

class CustomerListBloc extends Bloc<CustomerListEvent, CustomerListState> {
  CustomerListBloc() : super(CustomerListInitialState());
  final UserListRepository _userListRepository = locator<UserListRepository>();

  @override
  Stream<CustomerListState> mapEventToState(
    CustomerListEvent event,
  ) async* {
    if (event is GetCustomerListEvent) {
      try {
        final _userList = await _userListRepository.getApiCustomers();
        yield CustomerListLoadedState(userList: _userList);
      } catch (e) {
        yield CustomerListErrorState(error: "$e");
      }
    }
    if (event is SearchCustomerListEvent) {
      print("tryın üstü");
      try {
        yield CustomerListLoadingState();

        final userList =
            await _userListRepository.getApiCustomers(search: event.search);
        print(userList.body.first.fullName);
        yield CustomerListLoadedState(userList: userList);
      } catch (error) {
        yield CustomerListErrorState(error: error.toString());
      }
    }
    if (event is ClearCustomerListEvent) {
      yield CustomerListInitialState();
    }
  }
}
