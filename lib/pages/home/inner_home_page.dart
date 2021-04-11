import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:teknoloji_kimya_servis/helpers/notification_helper.dart';

class InnerHomePage extends StatefulWidget {
  final Widget child;
  InnerHomePage({Key key, @required this.child}) : super(key: key);

  @override
  _InnerHomePageState createState() => _InnerHomePageState();
}

class _InnerHomePageState extends State<InnerHomePage> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    NotificationHelper(context: context).initializeLocalNotification();

    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        try {
          NotificationHelper(context: context).showNotification(message);
        } catch (e) {
          print("firebaseMessaging onMessage, error: $e");
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.getToken().then((onValue) {
      debugPrint("FIREBASE TOKEN: " + onValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
