import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/models/api_sale.dart';
import 'package:teknoloji_kimya_servis/models/sale.dart';
import 'package:teknoloji_kimya_servis/repositories/sale/sale_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

part 'sale_event.dart';
part 'sale_state.dart';

class SaleBloc extends Bloc<SaleEvent, SaleState> {
  SaleBloc() : super(SaleInitialState());
  SaleListRepository _saleListRepository = locator<SaleListRepository>();
  @override
  Stream<SaleState> mapEventToState(
    SaleEvent event,
  ) async* {
    if (event is GetSaleEvent) {
      try {
        final _saleList = await _saleListRepository.getSale();
        print(_saleList.data.first.id);
        yield SaleLoadedState(sale: _saleList);
      } catch (e) {
        yield SaleFailureState(error: "");
      }
    }
    if (event is SearchSaleEvent) {
      print("tryın üstü");
      try {
        yield SaleLoadingState();

        final sale = await _saleListRepository.getSale(search: event.search);
        print(sale.data.first.companyName);
        yield SaleLoadedState(sale: sale);
      } catch (error) {
        yield SaleFailureState(error: "");
      }
    }
    if (event is ClearSaleEvent) {
      yield SaleInitialState();
    }
  }
}
