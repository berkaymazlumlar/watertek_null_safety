import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

import 'api_urls.dart';
import 'package:http/http.dart' as http;

AuthRepository _authRepository = locator<AuthRepository>();

class PutApi {
  static Future<dynamic> putUser({
    @required int isAdmin,
    @required int isCustomer,
    @required int isWorker,
    @required String id,
  }) async {
    try {
      final _response = await http.put(
        "${ApiUrls.users}/$id",
        headers: {
          "token": _authRepository.apiUser.token,
        },
        body: {
          "isAdmin": isAdmin.toString(),
          "isCustomer": isCustomer.toString(),
          "isWorker": isWorker.toString(),
        },
      );
      print(_response.body);
      if (_response.statusCode == 200) {
        return true;
      } else {
        return jsonDecode(_response.body)["message"];
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<dynamic> putSparePart({
    @required int count,
    @required String id,
  }) async {
    try {
      print("${ApiUrls.sparePart}/$id");
      final _response = await http.put(
        "${ApiUrls.sparePart}/$id",
        headers: {
          "token": _authRepository.apiUser.token,
        },
        body: {
          "count": count.toString(),
        },
      );
      print(_response.body);
      if (_response.statusCode == 200) {
        return true;
      } else {
        return jsonDecode(_response.body)["message"];
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<dynamic> putServiceReport({
    @required String pdfUrl,
    @required String id,
  }) async {
    try {
      print("${ApiUrls.serviceReport}/$id");
      final _response = await http.put(
        "${ApiUrls.serviceReport}/$id",
        headers: {
          "token": _authRepository.apiUser.token,
        },
        body: {
          "pdfUrl": pdfUrl,
        },
      );
      print(_response.body);
      if (_response.statusCode == 200) {
        return true;
      } else {
        return jsonDecode(_response.body)["message"];
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<dynamic> putCustomerRequestVideoUrl(
      {@required String videoUrl, @required int customerRequestId}) async {
    try {
      final _response = await http.put(
        "${ApiUrls.customerRequest}/$customerRequestId",
        headers: {
          "token": _authRepository.apiUser.token,
        },
        body: {
          "videoUrl": "$videoUrl",
        },
      );
      print(_response.body);
      if (_response.statusCode == 200) {
        return true;
      } else {
        return jsonDecode(_response.body)["message"];
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
