import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  int _selectedIcon = 0;
  int get selectedIcon => _selectedIcon;
  set selectedIcon(int selectedIcon) {
    _selectedIcon = selectedIcon;
    notifyListeners();
  }
}
