import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/api/get_apis.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_product.dart';
import 'package:teknoloji_kimya_servis/models/product.dart';

class ProductListRepository {
  ApiProduct _apiProduct;
  ApiProduct get apiProduct => _apiProduct;
  set apiProduct(ApiProduct apiProduct) {
    _apiProduct = apiProduct;
  }

  Future<ApiProduct> getProduct({String search}) async {
    final _response = await GetApi.getProduct(search: search);
    if (_response != null) {
      _apiProduct = _response;
      return _response;
    } else {
      return null;
    }
  }

  final List<Product> _myProducts = [];

  Future<List<Product>> getProductList() async {
    final List<Product> _myProducts = [];

    final _response =
        await FirebaseFirestore.instance.collection('product').get();
    for (var item in _response.docs) {
      _myProducts.add(Product.fromJson(item));
    }
    this._myProducts.addAll(_myProducts);
    _myProducts.sort((first, second) {
      return first.createdAt.compareTo(second.createdAt) * -1;
    });
    return _myProducts;
  }

  Future deleteProduct(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('product')
          .doc("$id")
          .delete();

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
