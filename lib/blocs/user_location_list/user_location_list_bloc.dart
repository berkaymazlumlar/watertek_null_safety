import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/models/user_location_list.dart';

part 'user_location_list_event.dart';
part 'user_location_list_state.dart';

class UserLocationListBloc
    extends Bloc<UserLocationListEvent, UserLocationListState> {
  UserLocationListBloc() : super(UserLocationListInitialState());

  @override
  Stream<UserLocationListState> mapEventToState(
    UserLocationListEvent event,
  ) async* {
    if (event is GetUserLocationListEvent) {
      try {
        final List<UserLocationList> _userLocationList = [];
        final _locations =
            await FirebaseFirestore.instance.collection("location").get();
        for (var item in _locations.docs) {
          _userLocationList.add(
            UserLocationList.fromJson(item),
          );
        }
        yield UserLocationListSuccessState(userLocationList: _userLocationList);
      } catch (e) {
        yield UserLocationListFailureState(error: "Hata: $e");
      }
    }
    if (event is ClearUserLocationListEvent) {
      yield UserLocationListInitialState();
    }
  }
}
