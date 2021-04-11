import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyLocalNotification {
  static final MyLocalNotification _instance = MyLocalNotification._internal();

  factory MyLocalNotification() {
    return _instance;
  }

  MyLocalNotification._internal() {
    print("FlutterLocalNotificationsPlugin oluşturuldu");
  }

  FlutterLocalNotificationsPlugin _localNotificationsPlugin;
  FlutterLocalNotificationsPlugin get localNotificationsPlugin =>
      _localNotificationsPlugin;
  set localNotificationsPlugin(
      FlutterLocalNotificationsPlugin localNotificationsPlugin) {
    _localNotificationsPlugin = localNotificationsPlugin;
    print("local notification setted");
  }
}
