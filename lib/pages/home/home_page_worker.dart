import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/pages/home/customer_main_page.dart';
import 'package:teknoloji_kimya_servis/pages/home/customer_user_operations.dart';
import 'package:teknoloji_kimya_servis/pages/home/main_page.dart';
import 'package:teknoloji_kimya_servis/pages/home/settings_page.dart';
import 'package:teknoloji_kimya_servis/pages/home/worker_location_page.dart';
import 'package:teknoloji_kimya_servis/pages/home/worker_user_operations.dart';
import 'package:teknoloji_kimya_servis/repositories/firebase.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

MyFirebase _myFirebase = locator<MyFirebase>();

class HomePageWorker extends StatefulWidget {
  HomePageWorker({Key key}) : super(key: key);

  @override
  _HomePageWorkerState createState() => _HomePageWorkerState();
}

class _HomePageWorkerState extends State<HomePageWorker> {
  //talepler ve qr tarayici
  List<Widget> _myPages = [
    MainPage(),
    WorkerUserOperations(),
    WorkerLocationPage(),
    SettingsPage(),
  ];
  int _selectedItemPosition = 0;
  @override
  void initState() {
    super.initState();
    _selectedItemPosition = 0;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final _firebaseFirestore = FirebaseFirestore.instance;
      _myFirebase.firebaseFirestore = _firebaseFirestore;
    });
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
            TabItem(icon: Icons.location_searching_outlined, title: 'Konum'),
            TabItem(icon: Icons.settings, title: 'Ayarlar'),
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
