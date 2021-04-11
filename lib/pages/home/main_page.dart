import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:teknoloji_kimya_servis/helpers/logout_helper.dart';
import 'package:teknoloji_kimya_servis/pages/home/calendar_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: FadeIn(
          duration: Duration(milliseconds: 500),
          child: Container(
            height: AppBar().preferredSize.height,
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        actions: [
          FadeIn(
            duration: Duration(milliseconds: 500),
            child: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                LogoutHelper(context: context).clearAllBlocsAndSignOut();
              },
            ),
          ),
        ],
      ),
      body: CalendarPage(),
    );
  }
}
