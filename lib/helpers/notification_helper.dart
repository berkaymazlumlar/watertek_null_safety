import 'dart:io';
import 'dart:math';

import 'package:eralpsoftware/eralpsoftware.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:teknoloji_kimya_servis/utils/local_notification.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

MyLocalNotification _localNotification = MyLocalNotification();

class NotificationHelper {
  final BuildContext context;
  NotificationHelper({
    @required this.context,
  });
  void initializeLocalNotification() {
    _initializeLocalNotification();
  }

  Future<void> _initializeLocalNotification() async {
    // tz.initializeTimeZones();
    // final String currentTimeZone =
    //     await FlutterNativeTimezone.getLocalTimezone();
    // print("current time zone: $currentTimeZone");
    // tz.setLocalLocation(tz.getLocation(currentTimeZone));

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/watertek');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );

    _localNotification.localNotificationsPlugin =
        flutterLocalNotificationsPlugin;
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Tamam'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ],
      ),
    );
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    Eralp.showSnackBar(
      snackBar: SnackBar(
        content: Text("$payload"),
      ),
    );
  }

  Future<void> showNotification(Map<String, dynamic> message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '${DateTime.now().add(Duration(milliseconds: 505)).millisecondsSinceEpoch}',
      'weekly channel name example',
      'weekly channel desc example',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    try {
      print("$message");
      if (Platform.isAndroid) {
        print("platform android");
        await _localNotification.localNotificationsPlugin.show(
          int.parse(
            DateTime.now().millisecondsSinceEpoch.toString().substring(4),
          ),
          '${message["notification"]["title"]}',
          '${message["notification"]["body"]}',
          platformChannelSpecifics,
        );
        print("completed");
      } else {
        print("platform ios");
        await _localNotification.localNotificationsPlugin.show(
          int.parse(
            DateTime.now().millisecondsSinceEpoch.toString().substring(4),
          ),
          '${message["aps"]["alert"]["title"]}',
          '${message["aps"]["alert"]["body"]}',
          platformChannelSpecifics,
        );
        print("completed");
      }
    } catch (e) {
      print("there is an error on _showNotification: $e");
    }
  }

  Future<void> setWeeklyNotifs() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '${DateTime.now().add(Duration(milliseconds: 505)).millisecondsSinceEpoch}',
      'weekly channel name example',
      'weekly channel desc example',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    // try {
    //   // await _localNotification.localNotificationsPlugin.cancelAll();
    //   setWeeklyNotif(Day.monday, 10);
    // } catch (e) {
    //   print(e);
    // }

    // setWeeklyNotif(
    //   Day.Monday,
    //   12,
    // );
    // setWeeklyNotif(
    //   Day.Monday,
    //   15,
    // );
    // setWeeklyNotif(
    //   Day.Monday,
    //   18,
    // );
    // setWeeklyNotif(
    //   Day.Monday,
    //   21,
    // );
    // setWeeklyNotif(
    //   Day.Tuesday,
    //   12,
    // );
    // setWeeklyNotif(
    //   Day.Tuesday,
    //   15,
    // );
    // setWeeklyNotif(
    //   Day.Tuesday,
    //   18,
    // );
    // setWeeklyNotif(
    //   Day.Tuesday,
    //   21,
    // );
    // setWeeklyNotif(
    //   Day.Wednesday,
    //   12,
    // );
    // setWeeklyNotif(
    //   Day.Wednesday,
    //   15,
    // );
    // setWeeklyNotif(
    //   Day.Wednesday,
    //   18,
    // );
    // setWeeklyNotif(
    //   Day.Wednesday,
    //   21,
    // );
    // setWeeklyNotif(
    //   Day.Thursday,
    //   12,
    // );
    // setWeeklyNotif(
    //   Day.Thursday,
    //   15,
    // );
    // setWeeklyNotif(
    //   Day.Thursday,
    //   18,
    // );
    // setWeeklyNotif(
    //   Day.Thursday,
    //   21,
    // );

    // setWeeklyNotif(
    //   Day.Friday,
    //   12,
    // );
    // setWeeklyNotif(
    //   Day.Friday,
    //   15,
    // );
    // setWeeklyNotif(
    //   Day.Friday,
    //   18,
    // );
    // setWeeklyNotif(
    //   Day.Friday,
    //   22,
    // );
    // setWeeklyNotif(
    //   Day.Saturday,
    //   12,
    // );
    // setWeeklyNotif(
    //   Day.Saturday,
    //   15,
    // );
    // setWeeklyNotif(
    //   Day.Saturday,
    //   18,
    // );
    // setWeeklyNotif(
    //   Day.Saturday,
    //   21,
    // );
    // setWeeklyNotif(
    //   Day.Sunday,
    //   12,
    // );
    // setWeeklyNotif(
    //   Day.Sunday,
    //   15,
    // );
    // setWeeklyNotif(
    //   Day.Sunday,
    //   18,
    // );
    // setWeeklyNotif(
    //   Day.Sunday,
    //   21,
    // );
  }

  Future<void> setWeeklyNotif(Day day, int hour) async {
    var time = Time(hour, 0, 0);
    await _localNotification.localNotificationsPlugin.zonedSchedule(
      Random().nextInt(9999),
      'scheduled title',
      'scheduled body',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
          android: AndroidNotificationDetails('your channel id',
              'your channel name', 'your channel description')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    // var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    //     '${DateTime.now().millisecondsSinceEpoch}',
    //     'weekly channel name example',
    //     'weekly channel desc example');
    // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    // var platformChannelSpecifics = NotificationDetails(
    //   android: androidPlatformChannelSpecifics,
    //   iOS: iOSPlatformChannelSpecifics,
    // );

    // _localNotification.localNotificationsPlugin.showWeeklyAtDayAndTime(
    //   int.parse(DateTime.now().millisecondsSinceEpoch.toString().substring(4)),
    //   'Hatırlatma bildirimi😎🧐',
    //   'Günde en az 2 litre su içmeyi unutmayın😊🥛💧',
    //   day,
    //   time,
    //   platformChannelSpecifics,
    // );
    print(
        "SET WEEKLY NOTIF OLUSTURULDU, DAY: ${day.value}, TIME: ${time.hour}");
  }
}
