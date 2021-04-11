import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/models/api_spare_part.dart';
import 'package:teknoloji_kimya_servis/models/spare_part.dart';
import 'package:teknoloji_kimya_servis/repositories/spare_part_list_repository/spare_part_list_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

part 'spare_part_list_event.dart';
part 'spare_part_list_state.dart';

class SparePartListBloc extends Bloc<SparePartListEvent, SparePartListState> {
  SparePartListBloc() : super(SparePartListInitialState());
  SparePartListRepository _sparePartListRepository =
      locator<SparePartListRepository>();

  @override
  Stream<SparePartListState> mapEventToState(
    SparePartListEvent event,
  ) async* {
    if (event is GetSparePartListEvent) {
      try {
        final _sparePartList = await _sparePartListRepository.getSparePart();
        print(_sparePartList.body.first.id);

        yield SparePartListLoadedState(sparePartList: _sparePartList);
      } catch (error) {
        yield SparePartListErrorState(error: "");
      }
    }
    if (event is ClearSparePartListEvent) {
      yield SparePartListInitialState();
    }
  }
}
