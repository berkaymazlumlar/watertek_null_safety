import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_dto.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:background_locator/settings/locator_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teknoloji_kimya_servis/helpers/logout_helper.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/firebase.dart';

import 'package:teknoloji_kimya_servis/utils/location_callback_handler.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

AuthRepository _authRepository = locator<AuthRepository>();
MyFirebase _myFirebase = locator<MyFirebase>();
const String _isolateName = "LocatorIsolate";
ReceivePort port = ReceivePort();

class WorkerLocationPage extends StatefulWidget {
  WorkerLocationPage({Key key}) : super(key: key);

  @override
  _WorkerLocationPageState createState() => _WorkerLocationPageState();
}

class _WorkerLocationPageState extends State<WorkerLocationPage> {
  @override
  void initState() {
    super.initState();
    // try {
    if (_myFirebase.listenPort) {
      port.listen((dynamic data) {
        print("runtime type: ${data.runtimeType}");
        // print("runtime latitude: ${data["latitude"]}");
        // print("runtime longitude: ${data["longitude"]}");
        if (data is LocationDto) {
          print("lat: ${data.latitude}");
          print("lng: ${data.longitude}");

          FirebaseFirestore.instance
              .collection('location')
              .doc("${_authRepository.apiUser.data.id}")
              .set(
                {
                  "lat": "${data.latitude}",
                  "lng": "${data.longitude}",
                  "updatedAt": "${DateTime.now()}",
                  "name": "${_authRepository.apiUser.data.fullName}",
                  "phone": "${_authRepository.apiUser.data.phone}",
                },
              )
              .then(
                (val) => print("firebase'ye value yazilmis olmasi lazim"),
              )
              .onError(
                (error, stackTrace) {
                  print("firebase ERROR: $error, trace: $stackTrace");
                },
              );
        }
      });
      _myFirebase.listenPort = false;
    }
    // } catch (e, trace) {
    //   print("error: $e, trace: $trace");
    // }

    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    await BackgroundLocator.initialize();
  }

  void callback(LocationDto locationDto) async {
    final SendPort send = IsolateNameServer.lookupPortByName(_isolateName);
    send?.send(locationDto);
    print("callback??");
  }

//Optional
  void notificationCallback() {
    print('User clicked on the notification');
    IsolateNameServer.removePortNameMapping(_isolateName);
    BackgroundLocator.unRegisterLocationUpdate();
  }

  void startLocationService() {
    BackgroundLocator.registerLocationUpdate(
      LocationCallbackHandler.callback,
      initCallback: LocationCallbackHandler.initCallback,
      disposeCallback: LocationCallbackHandler.disposeCallback,
      autoStop: false,
      iosSettings: IOSSettings(
        accuracy: LocationAccuracy.NAVIGATION,
        distanceFilter: 0,
      ),
      androidSettings: AndroidSettings(
        accuracy: LocationAccuracy.NAVIGATION,
        interval: 1800,
        distanceFilter: 0,
        androidNotificationSettings: AndroidNotificationSettings(
          notificationChannelName: 'Location tracking',
          notificationTitle: 'Konumunuz kullanılıyor',
          notificationMsg: 'Konumunuz arkaplanda kullanılıyor',
          notificationBigMsg:
              'Arkaplanda konumunuz kullanılıyor. Sisteme gereksiz yük binmemesi için işiniz bittiğinde uygulamaya girip servisi kapatabilirsiniz.',
          notificationIcon: '',
          notificationIconColor: Colors.grey,
          notificationTapCallback: LocationCallbackHandler.notificationCallback,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: FadeIn(
          duration: Duration(milliseconds: 500),
          child: Center(
            child: Text(
              'Konum Servisi',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                startLocationService();
              },
              child: Text("Servisi başlat"),
            ),
            ElevatedButton(
              onPressed: () {
                IsolateNameServer.removePortNameMapping(_isolateName);
                BackgroundLocator.unRegisterLocationUpdate();
              },
              child: Text("Servisi durdur"),
            ),
          ],
        ),
      ),
    );
  }
}
