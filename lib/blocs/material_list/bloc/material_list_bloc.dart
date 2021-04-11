import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:teknoloji_kimya_servis/models/api_material.dart';
import 'package:teknoloji_kimya_servis/repositories/material_repository/material_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

part 'material_list_event.dart';
part 'material_list_state.dart';

class MaterialListBloc extends Bloc<MaterialListEvent, MaterialListState> {
  MaterialListBloc() : super(MaterialListInitialState());
  MaterialRepository _materialListRepository = locator<MaterialRepository>();

  @override
  Stream<MaterialListState> mapEventToState(
    MaterialListEvent event,
  ) async* {
    if (event is GetMaterialListEvent) {
      try {
        final _materialList = await _materialListRepository.getMaterial();
        print(_materialList.body.first.id);

        yield MaterialListLoadedState(materialList: _materialList);
      } catch (error) {
        yield MaterialListErrorState(error: "");
      }
    }
    if (event is ClearMaterialListEvent) {
      yield MaterialListInitialState();
    }
  }
}
