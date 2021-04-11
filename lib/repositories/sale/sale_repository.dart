import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/api/get_apis.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_sale.dart';
import 'package:teknoloji_kimya_servis/models/sale.dart';

class SaleListRepository {
  final List<Sale> _mySales = [];
  ApiSale _apiSale;

  ApiSale get apiSale => _apiSale;

  set apiSale(ApiSale apiSale) {
    _apiSale = apiSale;
  }

  Future<ApiSale> getSale({String search}) async {
    final _response = await GetApi.getSale(search: search);
    if (_response != null) {
      _apiSale = _response;
      return _response;
    } else {
      return null;
    }
  }

  Future<List<Sale>> getSaleList() async {
    final List<Sale> _mySales = [];

    final _response = await FirebaseFirestore.instance.collection('sale').get();
    for (var item in _response.docs) {
      _mySales.add(Sale.fromJson(item));
    }
    this._mySales.addAll(_mySales);
    _mySales.sort((first, second) {
      return first.createdAt.compareTo(second.createdAt) * -1;
    });
    return _mySales;
  }

  Future deleteSale(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('sale').doc("$id").delete();

      MyFlushbarHelper(context: context).showSuccessFlushbar(
        title: "Başarılı",
        message: "Ürün silindi",
      );
    } catch (e) {
      MyFlushbarHelper(context: context).showErrorFlushbar(
        title: "Hata",
        message: "$e",
      );
    }
  }
}
