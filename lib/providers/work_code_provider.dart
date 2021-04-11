import 'package:flutter/cupertino.dart';
import 'package:teknoloji_kimya_servis/models/api_company.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';
import 'package:teknoloji_kimya_servis/models/company.dart';
import 'package:teknoloji_kimya_servis/models/user.dart';

class WorkCodeProvider with ChangeNotifier {
  ApiUsersData _myUser;
  ApiUsersData get myUser => _myUser;
  set myUser(ApiUsersData user) {
    _myUser = user;
    notifyListeners();
  }

  ApiUsersData _selectedCompany;
  ApiUsersData get selectedCompany => _selectedCompany;
  set selectedCompany(ApiUsersData company) {
    _selectedCompany = company;
    notifyListeners();
  }
}
