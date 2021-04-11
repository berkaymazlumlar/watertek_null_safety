import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';

class MyFirebase {
  MyFirebase() {
    print(
        "my firebase olusturuldu ve Permission.ignoreBatteryOptimizations.request(); ");
    Permission.ignoreBatteryOptimizations.request();
  }

  FirebaseFirestore _firebaseFirestore;
  FirebaseFirestore get firebaseFirestore => _firebaseFirestore;
  set firebaseFirestore(FirebaseFirestore firebaseFirestore) {
    _firebaseFirestore = firebaseFirestore;
    print("firebase firestore setted");
  }

  bool _listenPort = true;
  bool get listenPort => _listenPort;
  set listenPort(bool listenPort) {
    _listenPort = listenPort;
    print("listen port setted");
  }
}
