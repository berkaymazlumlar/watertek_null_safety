import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:teknoloji_kimya_servis/api/get_apis.dart';
import 'package:teknoloji_kimya_servis/models/api_spare_part.dart';
import 'package:teknoloji_kimya_servis/models/spare_part.dart';

class SparePartListRepository {
  final List<SparePart> _sparePartList = [];

  ApiSparePart _apiSparePart;

  ApiSparePart get apiSparePart => _apiSparePart;

  set apiSparePart(ApiSparePart apiSparePart) {
    _apiSparePart = apiSparePart;
  }

  Future<ApiSparePart> getSparePart() async {
    final _sparePart = await GetApi.getSparePart();
    if (_sparePart is ApiSparePart) {
      _apiSparePart = _sparePart;
      return _sparePart;
    }
    return null;
  }

  Future<List<SparePart>> getSparePartList() async {
    final List<SparePart> _sparePartList = [];
    final _response =
        await FirebaseFirestore.instance.collection("spare_part").get();

    for (var item in _response.docs) {
      _sparePartList.add(SparePart.fromJson(item));
    }

    this._sparePartList.addAll(_sparePartList);
    return _sparePartList;
  }

  deleteSparePart(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection("spare_part")
          .doc("$id")
          .delete();
      return FlushbarHelper.createSuccess(
          title: "Başarılı", message: "Yedek parça silindi")
        ..show(context);
    } catch (e) {
      return FlushbarHelper.createError(title: "Hata", message: "$e")
        ..show(context);
    }
  }
}
