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
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    NotificationHelper(context: context).initializeLocalNotification();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      try {
        NotificationHelper(context: context).showNotification(message.data);
      } catch (e) {
        print("firebaseMessaging onMessage, error: $e");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) {
      print("onBackgroundMessage: $message");
    });

    _firebaseMessaging.getToken().then((onValue) {
      debugPrint("FIREBASE TOKEN: " + onValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
