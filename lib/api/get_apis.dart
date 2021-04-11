import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/api/api_urls.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_company.dart';
import 'package:teknoloji_kimya_servis/models/api_exploration.dart';
import 'package:teknoloji_kimya_servis/models/api_health_report.dart';
import 'package:teknoloji_kimya_servis/models/api_material.dart';
import 'package:teknoloji_kimya_servis/models/api_periodic_maintenance.dart';
import 'package:teknoloji_kimya_servis/models/api_product.dart';
import 'package:http/http.dart' as http;
import 'package:teknoloji_kimya_servis/models/api_request.dart';
import 'package:teknoloji_kimya_servis/models/api_sale.dart';
import 'package:teknoloji_kimya_servis/models/api_service_report.dart';
import 'package:teknoloji_kimya_servis/models/api_spare_part.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';
import 'package:teknoloji_kimya_servis/models/api_work_code.dart';
import 'package:teknoloji_kimya_servis/models/api_work_order.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

AuthRepository _authRepository = locator<AuthRepository>();

class GetApi {
  static Future<ApiCompany> getCompany() async {
    final _response = await http.get(
      "${ApiUrls.company}?order=desc",
      headers: {
        "token": "${_authRepository.apiUser.token}",
      },
    );

    if (_response.statusCode == 200) {
      return apiCompanyFromJson(_response.body);
    } else {
      return null;
    }
  }

  static Future<ApiSparePart> getSparePart() async {
    final _response = await http.get(
      "${ApiUrls.baseUrl}/i/j/spare_part/product?filter=t1.productId=t2.id&fields=t1.*,t2.name productName,t2.model as productModel, t2.createdAt as productCreatedAt&order=desc",
      headers: {
        "token": "${_authRepository.apiUser.token}",
      },
    );

    if (_response.statusCode == 200) {
      return apiSparePartFromJson(_response.body);
    } else {
      return null;
    }
  }

  static Future<ApiSale> getSaleWithBarcode(
      {@required String barcodeNumber}) async {
    try {
      Dio dio = Dio();
      (dio.transformer as DefaultTransformer).jsonDecodeCallback =
          apiSaleFromJson;

      final _response = await dio.get(
        "${ApiUrls.getSale}?order=desc",
        options: Options(
          headers: {
            "token": "${_authRepository.apiUser.token}",
          },
        ),
        queryParameters: {
          "barcodeNumber": "$barcodeNumber",
        },
      );
      if (_response.statusCode == 200) {
        return _response.data;
      } else {
        return null;
      }
    } catch (e) {
      print("there is an error getting barcodeSale");
      return null;
    } finally {}
  }

  static Future<ApiPeriodicMaintenance> getSpecificPeriodicMaintenance(
      final String id) async {
    try {
      // EralpHelper.startProgress();
      final _response = await http.get(
        "${ApiUrls.baseUrl}/i/j/periodic_maintenance/user?filter=t1.userId=t2.id,t1.id=$id&fields=t1.*,t2.fullname as companyName,t2.phone as companyPhone, t2.createdAt as companyCreatedAt&order=desc",
        headers: {
          "token": "${_authRepository.apiUser.token}",
        },
      );
      if (_response.statusCode == 200) {
        return apiPeriodicMaintenanceFromJson(_response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(
          "there is an error while getting getSpecificPeriodicMaintenance: $e");
      return null;
    } finally {
      EralpHelper.stopProgress();
    }
  }

  static Future<ApiUsers> getApiUserWithId(final String userId) async {
    try {
      EralpHelper.startProgress();
      final _response = await http.get(
        "${ApiUrls.users}/$userId",
        headers: {
          "token": "${_authRepository.apiUser.token}",
        },
      );

      if (_response.statusCode == 200) {
        print(_response.body);
        final ApiUsers _apiUser = apiUsersFromJsonRequestPage(_response.body);
        print("user_list_repository _response: ${_apiUser.toJson()}");

        return _apiUser;
      } else {
        return null;
      }
    } catch (e) {
      print("there is an error while getting getApiUsers: $e");
      return null;
    } finally {
      EralpHelper.stopProgress();
    }
  }

  static Future<ApiWorkOrder> getWorkOrder(
      {String search, int workerId}) async {
    String _url = "";
    if (search != null) {
      _url =
          "${ApiUrls.getWorkOrder}?order=desc&searchFields=b.fullname&search=$search";
    } else {
      _url = "${ApiUrls.getWorkOrder}?order=desc";
    }
    print("url: $_url");
    final _response = await http.get(
      _url,
      headers: {
        "token": "${_authRepository.apiUser.token}",
      },
    );

    if (_response.statusCode == 200) {
      return apiWorkOrderFromJson(_response.body);
    } else {
      return null;
    }
  }

  static Future<ApiServiceReport> getServiceReport({String search}) async {
    String _url = "";
    if (search != null) {
      _url =
          "${ApiUrls.getServiceReport}?order=desc&searchFields=name&search=$search";
    } else {
      _url = "${ApiUrls.getServiceReport}?order=desc";
    }
    print("url: $_url");
    final _response = await http.get(
      _url,
      headers: {
        "token": "${_authRepository.apiUser.token}",
      },
    );

    if (_response.statusCode == 200) {
      return apiServiceReportFromJson(_response.body);
    } else {
      return null;
    }
  }

  static Future<ApiPeriodicMaintenance> getPeriodicMaintenance(
      {String search, int customerId}) async {
    String _url = "";
    if (search != null) {
      if (customerId != null) {
        _url =
            "${ApiUrls.baseUrl}/i/j/periodic_maintenance/user?filter=t1.userId=t2.id,t1.userId=$customerId&fields=t1.*,t2.fullname as companyName,t2.phone as companyPhone, t2.createdAt as companyCreatedAt&order=desc&searchFields=fullName&search=$search";
      } else {
        _url =
            "${ApiUrls.baseUrl}/i/j/periodic_maintenance/user?filter=t1.userId=t2.id&fields=t1.*,t2.fullname as companyName,t2.phone as companyPhone, t2.createdAt as companyCreatedAt&order=desc&searchFields=fullName&search=$search";
      }
    } else {
      if (customerId != null) {
        _url =
            "${ApiUrls.baseUrl}/i/j/periodic_maintenance/user?filter=t1.userId=t2.id,t1.userId=$customerId&fields=t1.*,t2.fullname as companyName,t2.phone as companyPhone, t2.createdAt as companyCreatedAt&order=desc";
      } else {
        _url =
            "${ApiUrls.baseUrl}/i/j/periodic_maintenance/user?filter=t1.userId=t2.id&fields=t1.*,t2.fullname as companyName,t2.phone as companyPhone, t2.createdAt as companyCreatedAt&order=desc";
      }
    }
    print("url: $_url");
    try {
      final _response = await http.get(
        _url,
        headers: {
          "token": "${_authRepository.apiUser.token}",
        },
      );

      if (_response.statusCode == 200) {
        return apiPeriodicMaintenanceFromJson(_response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("there is an error while getting periodic maintenance: $e");
      return null;
    }
  }

  static Future<ApiProduct> getProduct({String search}) async {
    String _url = "";
    if (search != null) {
      _url =
          "https://teknomkimya.herokuapp.com/i/j/product/material?filter=t1.materialId=t2.id&fields=t1.*,t2.materialName as materialName,t2.materialModel as materialModel, t2.createdAt as materialCreatedAt,t2.materialPrice as materialPrice&order=desc&search=$search";
    } else {
      _url =
          "https://teknomkimya.herokuapp.com/i/j/product/material?filter=t1.materialId=t2.id&fields=t1.*,t2.materialName as materialName,t2.materialModel as materialModel, t2.createdAt as materialCreatedAt,t2.materialPrice as materialPrice&order=desc";
    }
    print("url: $_url");

    final _response = await http.get(
      _url,
      headers: {
        "token": "${_authRepository.apiUser.token}",
      },
    );

    if (_response.statusCode == 200) {
      return apiProductFromJson(_response.body);
    } else {
      return null;
    }
  }

  static Future<ApiSale> getSale({String barcodeNumber, String search}) async {
    String _url = "";
    if (search != null) {
      _url =
          "${ApiUrls.getSale}?order=desc&searchFields=c.fullname&search=$search";
    } else {
      _url = "${ApiUrls.getSale}?order=desc";
    }
    print("url: $_url");
    final _response = await http.get(
      _url,
      headers: {
        "token": "${_authRepository.apiUser.token}",
      },
    );

    if (_response.statusCode == 200) {
      return apiSaleFromJson(_response.body);
    } else {
      return null;
    }
  }

  static Future<ApiUsers> getApiUsers({String search}) async {
    String _url = "";
    if (search != null) {
      _url = "${ApiUrls.users}?order=desc&searchFields=fullName&search=$search";
    } else {
      _url = "${ApiUrls.users}?order=desc";
    }
    print("url: $_url");
    try {
      EralpHelper.startProgress();
      final _response = await http.get(
        _url,
        headers: {
          "token": "${_authRepository.apiUser.token}",
        },
      );
      if (_response.statusCode == 200) {
        return apiUsersFromJson(_response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("there is an error while getting getApiUsers: $e");
      return null;
    } finally {
      EralpHelper.stopProgress();
    }
  }

  static Future<ApiUsers> getApiWorkers({String search}) async {
    String _url = "";
    if (search != null) {
      _url =
          "${ApiUrls.users}?order=desc&filter=isWorker=1&searchFields=fullName&search=$search";
    } else {
      _url = "${ApiUrls.users}?order=desc&filter=isWorker=1";
    }
    print("url: $_url");
    try {
      EralpHelper.startProgress();
      final _response = await http.get(
        _url,
        headers: {
          "token": "${_authRepository.apiUser.token}",
        },
      );
      if (_response.statusCode == 200) {
        return apiUsersFromJson(_response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("there is an error while getting getApiUsers: $e");
      return null;
    } finally {
      EralpHelper.stopProgress();
    }
  }

  static Future<ApiUsers> getApiCustomers({String search}) async {
    String _url = "";
    if (search != null) {
      _url =
          "${ApiUrls.users}?order=desc&filter=isCustomer=1&searchFields=fullName&search=$search";
    } else {
      _url = "${ApiUrls.users}?order=desc&filter=isCustomer=1";
    }
    print("url: $_url");
    try {
      EralpHelper.startProgress();
      final _response = await http.get(
        _url,
        headers: {
          "token": "${_authRepository.apiUser.token}",
        },
      );
      if (_response.statusCode == 200) {
        return apiUsersFromJson(_response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("there is an error while getting getApiUsers: $e");
      return null;
    } finally {
      EralpHelper.stopProgress();
    }
  }

  static Future<ApiCustomerRequest> getCustomerRequest({int customerId}) async {
    String _url = "";
    if (customerId == null) {
      _url =
          "https://teknomkimya.herokuapp.com/i/j/customer_request/user?filter=t1.userId=t2.id&fields=t1.*,t2.fullname as userFullname,t2.phone as userphone&order=desc";
    } else {
      _url =
          "https://teknomkimya.herokuapp.com/i/j/customer_request/user?filter=t1.userId=t2.id,t1.userId=$customerId&fields=t1.*,t2.fullname as userFullname,t2.phone as userphone&order=desc";
    }
    final _response = await http.get(
      _url,
      headers: {
        "token": "${_authRepository.apiUser.token}",
      },
    );
    print(_response.body);

    if (_response.statusCode == 200) {
      return apiCustomerRequestFromJson(_response.body);
    } else {
      return null;
    }
  }

  static Future<ApiExploration> getExplorationList() async {
    final _response = await http.get(
      "${ApiUrls.baseUrl}/i/j/exploration/user?filter=t1.userId=t2.id&fields=t1.*,t2.fullName as companyName,t2.phone as companyPhone&order=desc",
      headers: {
        "token": "${_authRepository.apiUser.token}",
      },
    );

    if (_response.statusCode == 200) {
      return apiExplorationFromJson(_response.body);
    } else {
      return jsonDecode(_response.body)["message"];
    }
  }

  static Future<ApiHealthReport> getHealthReport() async {
    final _response = await http.get(
      "${ApiUrls.baseUrl}/i/j/health_report/user?filter=t1.userId=t2.id&fields=t1.*,t2.fullname as workerName,t2.phone as workerPhone&order=desc",
      headers: {
        "token": "${_authRepository.apiUser.token}",
      },
    );

    if (_response.statusCode == 200) {
      return apiHealthReportFromJson(_response.body);
    } else {
      return jsonDecode(_response.body)["message"];
    }
  }

  static Future<ApiUsers> getCustomerList({String search}) async {
    try {
      EralpHelper.startProgress();
      final _response = await http.get(
        "${ApiUrls.users}?order=desc&filter=isCustomer=1",
        headers: {
          "token": "${_authRepository.apiUser.token}",
        },
      );
      if (_response.statusCode == 200) {
        return apiUsersFromJson(_response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("there is an error while getting getApiUsers: $e");
      return null;
    } finally {
      EralpHelper.stopProgress();
    }
  }

  static Future<ApiWorkCode> getWorkCode() async {
    try {
      EralpHelper.startProgress();
      final _response = await http.get(
        "${ApiUrls.getWorkCode}?order=desc",
        headers: {
          "token": "${_authRepository.apiUser.token}",
        },
      );
      if (_response.statusCode == 200) {
        return apiWorkCodeFromJson(_response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("there is an error while getting getApiUsers: $e");
      return null;
    } finally {
      EralpHelper.stopProgress();
    }
  }

  static Future<ApiMaterial> getMaterial() async {
    try {
      EralpHelper.startProgress();
      final _response = await http.get(
        "${ApiUrls.material}?order=desc",
        headers: {
          "token": "${_authRepository.apiUser.token}",
        },
      );
      if (_response.statusCode == 200) {
        return apiMaterialFromJson(_response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("there is an error while getting getApiUsers: $e");
      return null;
    } finally {
      EralpHelper.stopProgress();
    }
  }
}
