import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/models/api_product.dart';
import 'package:teknoloji_kimya_servis/repositories/product_list/product_list_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:teknoloji_kimya_servis/models/product.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListInitialState());
  final ProductListRepository _productListRepository =
      locator<ProductListRepository>();

  @override
  Stream<ProductListState> mapEventToState(
    ProductListEvent event,
  ) async* {
    if (event is GetProductListEvent) {
      try {
        // final _productList = await _productListRepository.getProductList();
        final _productList = await _productListRepository.getProduct();
        if (_productList is ApiProduct) {
          yield ProductListLoadedState(productList: _productList);
        } else {
          yield ProductListErrorState(error: "");
        }
      } catch (e) {
        yield ProductListErrorState(error: "");
      }
    }
    if (event is SearchProductListEvent) {
      print("tryın üstü");
      try {
        yield ProductListLoadingState();

        final productList =
            await _productListRepository.getProduct(search: event.search);
        print(productList.body.first.name);
        yield ProductListLoadedState(productList: productList);
      } catch (error) {
        yield ProductListErrorState(error: "");
      }
    }
    if (event is ClearProductListEvent) {
      yield ProductListInitialState();
    }
  }
}
