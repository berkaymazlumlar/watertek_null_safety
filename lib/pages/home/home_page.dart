import 'dart:math';

import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/helpers/context_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/notification_helper.dart';
import 'package:teknoloji_kimya_servis/pages/company/company_list_page.dart';
import 'package:teknoloji_kimya_servis/pages/home/settings_page.dart';
import 'package:teknoloji_kimya_servis/pages/home/user_operations.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/utils/local_notification.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'main_page.dart';

AuthRepository _authRepository = locator<AuthRepository>();
MyLocalNotification _myLocalNotification = MyLocalNotification();

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _myPages = [
    MainPage(),
    UserOperations(),
    CompanyListPage(),
    SettingsPage(),
  ];
  int _selectedItemPosition = 0;
  @override
  void initState() {
    super.initState();

    _selectedItemPosition = 0;
    NotificationHelper(
      context: context,
    ).initializeLocalNotification();
    NotificationHelper(
      context: context,
    ).setWeeklyNotifs();
  }

  @override
  Widget build(BuildContext context) {
    ContextHelper().context = context;

    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Theme.of(context).primaryColor,
          items: [
            TabItem(icon: Icons.home, title: 'Anasayfa'),
            TabItem(icon: Icons.emoji_objects, title: 'İşlemler'),
            TabItem(icon: Icons.home_repair_service, title: 'Müşteriler'),
            TabItem(icon: Icons.settings, title: 'Ayarlar'),
            // TabItem(icon: Icons.calendar_today, title: 'Takvim'),
          ],
          initialActiveIndex: 0, //optional, default as 0
          onTap: (int index) {
            _selectedItemPosition = index;
            setState(() {});
          },
        ),
        // body: AnimatedSwitcher(
        // transitionBuilder: (widget, animation) => FadeTransition(
        //   opacity: animation,
        //   child: widget,
        // ),
        // duration: Duration(milliseconds: 500),
        // child:
        body: _myPages[_selectedItemPosition],
        // ),
      ),
    );
  }
}
