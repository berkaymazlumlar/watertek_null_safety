import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/models/api_company.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';
import 'package:teknoloji_kimya_servis/models/company.dart';

class PeriodicMaintenanceProvider with ChangeNotifier {
  ApiUsersData _selectedCompany;
  ApiUsersData get selectedCompany => _selectedCompany;
  set selectedCompany(ApiUsersData company) {
    _selectedCompany = company;
    notifyListeners();
  }
}
