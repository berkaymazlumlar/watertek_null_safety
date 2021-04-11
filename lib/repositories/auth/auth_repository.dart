import 'package:teknoloji_kimya_servis/models/api_user.dart';

class AuthRepository {
  ApiUser _apiUser;
  ApiUser get apiUser => _apiUser;
  set apiUser(ApiUser apiUser) {
    _apiUser = apiUser;
  }
}
