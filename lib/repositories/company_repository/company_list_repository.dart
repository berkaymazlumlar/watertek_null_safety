import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/api/delete_apis.dart';
import 'package:teknoloji_kimya_servis/api/get_apis.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_company.dart';
import 'package:teknoloji_kimya_servis/models/company.dart';

class CompanyListRepository {
  ApiCompany _myCompanies;

  ApiCompany get myCompanies => _myCompanies;

  set myCompanies(ApiCompany myCompanies) {
    _myCompanies = myCompanies;
  }

  Future<ApiCompany> getCompanyList() async {
    final _response = await GetApi.getCompany();
    if (_response is ApiCompany) {
      myCompanies = _response;
      return myCompanies;
    }
    return null;
  }

  Future addCompany(String name, String phoneNo, BuildContext context) async {
    try {
      final _response =
          await FirebaseFirestore.instance.collection('company').add(
        {
          "id": "${DateTime.now().microsecondsSinceEpoch}",
          "name": "$name",
          "phone": "$phoneNo"
        },
      );
      MyFlushbarHelper(context: context).showSuccessFlushbar(
        title: "Başarılı",
        message: "Firma eklendi",
      );
      print(_response.toString());
    } catch (e) {
      MyFlushbarHelper(context: context).showErrorFlushbar(
        title: "Hata",
        message: "$e",
      );
    }
  }

  Future<bool> deleteCompany(String id, BuildContext context) async {
    try {
      final _isSuccess = await DeleteApi.deleteCompany(id);
      if (_isSuccess) {
        MyFlushbarHelper(context: context).showSuccessFlushbar(
          title: "Başarılı",
          message: "Müşteri silindi",
        );
        return true;
      } else {
        MyFlushbarHelper(context: context).showErrorFlushbar(
          title: "Hata",
          message: "Müşteri silinemedi",
        );
        return false;
      }
      // print(_response.toString());
    } catch (e) {
      MyFlushbarHelper(context: context).showErrorFlushbar(
        title: "Hata",
        message: "$e",
      );
      return false;
    }
  }
}
