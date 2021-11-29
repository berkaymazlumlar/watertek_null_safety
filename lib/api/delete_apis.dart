import 'package:teknoloji_kimya_servis/api/api_urls.dart';
import 'package:teknoloji_kimya_servis/models/api_company.dart';
import 'package:teknoloji_kimya_servis/models/api_product.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:http/http.dart' as http;

AuthRepository _authRepository = locator<AuthRepository>();

class DeleteApi {
  static Future<bool> deleteProduct(String id) async {
    final _response = await http.delete(
      Uri.parse("${ApiUrls.product}/$id"),
      headers: {
        "token": "${_authRepository.apiUser.token}",
      },
    );

    if (_response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteCompany(String id) async {
    try {
      final _response = await http.delete(
        Uri.parse("${ApiUrls.company}/$id"),
        headers: {
          "token": "${_authRepository.apiUser.token}",
        },
      );
      print(_response.body);
      if (_response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      // TODO
      print(e);
      return false;
    }
  }
}
