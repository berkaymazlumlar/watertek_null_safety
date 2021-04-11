import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/api/api_urls.dart';
import 'package:teknoloji_kimya_servis/models/api_sale.dart';
import 'package:teknoloji_kimya_servis/models/api_user.dart';
import 'package:http/http.dart' as http;
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

AuthRepository _authRepository = locator<AuthRepository>();

class PostApi {
  static Future<ApiUser> login({
    @required String username,
    @required String password,
  }) async {
    final _response = await http.post(
      ApiUrls.loginUrl,
      body: {
        "username": username,
        "password": password,
      },
    );

    if (_response.statusCode == 200) {
      return apiUserFromJson(_response.body);
    } else {
      return null;
    }
  }

  static Future<dynamic> signUp({
    @required String username,
    @required String password,
    @required String fullName,
    @required String phone,
  }) async {
    final _response = await http.post(
      ApiUrls.signUpUrl,
      body: {
        "username": username,
        "password": password,
        "fullName": fullName,
        "phone": phone,
      },
    );

    if (_response.statusCode == 200) {
      return true;
    } else {
      return jsonDecode(_response.body)["message"];
    }
  }

  static Future<dynamic> addProduct({
    @required String name,
    @required String model,
    @required String materialId,
  }) async {
    final _response = await http.post(
      ApiUrls.product,
      headers: {
        "token": _authRepository.apiUser.token,
      },
      body: {
        "name": name,
        "model": model,
        "materialId": materialId,
      },
    );

    if (_response.statusCode == 200) {
      return true;
    } else {
      return jsonDecode(_response.body)["message"];
    }
  }

  static Future<dynamic> addCompany({
    @required String name,
    @required String phone,
  }) async {
    try {
      final _response = await http.post(
        ApiUrls.company,
        headers: {
          "token": _authRepository.apiUser.token,
        },
        body: {
          "name": name,
          "phone": phone,
        },
      );
      print(_response.body);
      if (_response.statusCode == 200) {
        return true;
      } else {
        return jsonDecode(_response.body)["message"];
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

// {
//     "productId":1,
//     "name":"yedek deneme2",
//     "count":"5",
//     "price":"3 tl"
// }
  static Future<dynamic> addSparePart({
    @required int productId,
    @required String name,
    @required String count,
    @required String price,
  }) async {
    try {
      print("url: ${ApiUrls.sparePart}");
      print(
        jsonEncode(
          {
            "productId": "$productId",
            "name": "$name",
            "count": "$count",
            "price": "$price",
          },
        ),
      );

      final _response = await http.post(
        "https://teknomkimya.herokuapp.com/spare_part",
        headers: {
          "token": _authRepository.apiUser.token,
          'Content-Type': 'application/json'
        },
        body: jsonEncode(
          {
            "productId": "$productId",
            "name": "$name",
            "count": "$count",
            "price": "$price",
          },
        ),
      );
      if (_response.statusCode == 200) {
        return true;
      } else {
        return jsonDecode(_response.body)["message"];
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  static Future<dynamic> addSale({
    @required String companyId,
    @required String productId,
    @required DateTime setupDate,
    @required DateTime warrantyDate,
    @required String barcode,
    @required String departman,
    @required String lokasyon,
  }) async {
    try {
      final _response = await http.post(
        ApiUrls.sales,
        headers: {
          "token": _authRepository.apiUser.token,
        },
        body: {
          "departman": departman,
          "lokasyon": lokasyon,
          "userId": companyId,
          "productId": productId,
          "setupDate": setupDate.toString(),
          "warrantyDate": warrantyDate.toString(),
          "barcode": barcode
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
      return null;
    }
  }

  static Future<dynamic> getSaleWithBarcode({
    @required String barcodeNumber,
  }) async {
    try {
      final _response = await http.post(
        ApiUrls.getSale,
        headers: {
          "token": _authRepository.apiUser.token,
        },
        body: {
          "barcodeNumber": "$barcodeNumber",
        },
      );
      if (_response.statusCode == 200) {
        return apiSaleFromJson(_response.body);
      } else {
        return jsonDecode(_response.body)["message"];
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  static Future<dynamic> addPeriodicMaintenance({
    @required String companyId,
    @required int period,
    @required DateTime firstPeriodDate,
  }) async {
    try {
      final _response = await http.post(
        ApiUrls.periodicMaintenance,
        headers: {
          'Content-Type': 'application/json',
          "token": _authRepository.apiUser.token,
        },
        body: jsonEncode(
          {
            "userId": companyId,
            "period": period,
            "firstPeriodDate": firstPeriodDate.toString(),
          },
        ),
      );
      print(_response.body);
      if (_response.statusCode == 200) {
        return true;
      } else {
        return jsonDecode(_response.body)["message"];
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  static Future<dynamic> addWorkOrder({
    @required String companyId,
    @required String userId,
    @required String taskDescription,
    @required String pdfUrl,
    @required DateTime taskDate,
  }) async {
    try {
      final _response = await http.post(
        ApiUrls.workOrder,
        headers: {
          "token": _authRepository.apiUser.token,
        },
        body: {
          "companyId": companyId,
          "userId": userId,
          "taskDate": taskDate.toString(),
          "taskDescription": taskDescription,
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
      return null;
    }
  }

  static Future<dynamic> addHealthReport({
    @required String userId,
    @required String fullName,
    @required String phone,
    @required DateTime startDate,
    @required DateTime expirationDate,
  }) async {
    try {
      final _response = await http.post(
        ApiUrls.healthReport,
        headers: {
          "token": _authRepository.apiUser.token,
        },
        body: {
          "userId": userId,
          "startDate": startDate.toString(),
          "expirationDate": expirationDate.toString(),
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
      return null;
    }
  }

  static Future<dynamic> addWorkCode({
    @required String userId,
    @required String customerId,
    @required String fullName,
    @required String phone,
    @required String department,
    @required String workCode,
    @required DateTime startDate,
    @required DateTime expirationDate,
  }) async {
    try {
      final _response = await http.post(
        ApiUrls.workCode,
        headers: {
          "token": _authRepository.apiUser.token,
        },
        body: {
          "workerId": userId,
          "customerId": customerId,
          "department": department,
          "startDate": startDate.toString(),
          "expirationDate": expirationDate.toString(),
          "workCode": workCode
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
      return null;
    }
  }

  static Future<dynamic> addServiceReport() async {
    try {
      final _response = await http.post(
        ApiUrls.workOrder,
        headers: {
          "token": _authRepository.apiUser.token,
        },
        body: {},
      );
      print(_response.body);
      if (_response.statusCode == 200) {
        return true;
      } else {
        return jsonDecode(_response.body)["message"];
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  static Future<dynamic> addMaterial({
    @required String materialName,
    @required String materialModel,
    @required int materialPrice,
  }) async {
    try {
      final _response = await http.post(
        ApiUrls.material,
        headers: {
          "token": _authRepository.apiUser.token,
        },
        body: {
          "materialName": "$materialName",
          "materialModel": "$materialModel",
          "materialPrice": "$materialPrice",
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
      return null;
    }
  }

  static Future<dynamic> addCustomerRequest({
    @required String description,
    @required String title,
    @required String userId,
    @required String videoUrl,
  }) async {
    try {
      final _response = await http.post(
        ApiUrls.customerRequest,
        headers: {
          "token": _authRepository.apiUser.token,
        },
        body: {
          "title": "$title",
          "description": "$description",
          "userId": "$userId",
          "videoUrl": "$videoUrl",
        },
      );
      print(_response.body);
      if (_response.statusCode == 200) {
        return jsonDecode(_response.body)["id"];
      } else {
        return jsonDecode(_response.body)["message"];
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  static Future<dynamic> addExplorationReport({
    @required Map<String, dynamic> map,
  }) async {
    try {
      final _response = await http.post(
        ApiUrls.exploration,
        headers: {
          "token": _authRepository.apiUser.token,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          map,
        ),
      );
      print(_response.body);
      if (_response.statusCode == 200) {
        return jsonDecode(_response.body)["id"];
      } else {
        return jsonDecode(_response.body)["message"];
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  static Future<dynamic> addServiceReportSpareParts({
    @required Map<String, dynamic> map,
  }) async {
    try {
      final _response = await http.post(
        ApiUrls.serviceReportSpareParts,
        headers: {
          "token": _authRepository.apiUser.token,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          map,
        ),
      );
      print(_response.body);
      if (_response.statusCode == 200) {
        return true;
      } else {
        return jsonDecode(_response.body)["message"];
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
