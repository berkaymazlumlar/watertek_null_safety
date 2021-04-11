import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/pages/home/customer_main_page.dart';
import 'package:teknoloji_kimya_servis/pages/home/customer_user_operations.dart';
import 'package:teknoloji_kimya_servis/pages/home/settings_page.dart';

class HomePageCustomer extends StatefulWidget {
  HomePageCustomer({Key key}) : super(key: key);

  @override
  _HomePageCustomerState createState() => _HomePageCustomerState();
}

class _HomePageCustomerState extends State<HomePageCustomer> {
  //talepler ve qr tarayici
  List<Widget> _myPages = [
    CustomerMainPage(),
    CustomerUserOperations(),
    SettingsPage(),
  ];
  int _selectedItemPosition = 0;
  @override
  void initState() {
    super.initState();
    _selectedItemPosition = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: _myPages[_selectedItemPosition],
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Theme.of(context).primaryColor,
          items: [
            TabItem(icon: Icons.home, title: 'Anasayfa'),
            TabItem(icon: Icons.emoji_objects, title: 'İşlemler'),
            TabItem(icon: Icons.settings, title: 'Ayarlar'),
            // TabItem(icon: Icons.calendar_today, title: 'Takvim'),
          ],
          initialActiveIndex: 0, //optional, default as 0
          onTap: (int index) {
            _selectedItemPosition = index;
            setState(() {});
          },
        ),
      ),
    );
  }
}
