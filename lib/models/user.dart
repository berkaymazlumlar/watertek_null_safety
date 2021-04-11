import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<MyUser> userFromJson(String str) =>
    List<MyUser>.from(json.decode(str).map((x) => MyUser.fromJson(x)));

String userToJson(MyUser data) => json.encode(data.toJson());

class MyUser {
  MyUser({
    this.userId,
    this.name,
    this.phone,
    this.isAdmin,
    this.isCustomer,
    this.isWorker,
  });
  String userId;
  String name;
  String phone;
  bool isWorker;
  bool isAdmin;
  bool isCustomer;

  factory MyUser.fromJson(Map<String, dynamic> json) => MyUser(
        name: json["name"],
        phone:
            "${json["phone"].toString().substring(0, 1)} (${json["phone"].toString().substring(1, 4)}) ${json["phone"].toString().substring(4, 7)} ${json["phone"].toString().substring(7, 9)} ${json["phone"].toString().substring(9, 11)}",
        isWorker: json["isWorker"],
        isAdmin: json["isAdmin"],
        isCustomer: json["isCustomer"],
      );
  factory MyUser.fromQueryDocumentSnapshot(QueryDocumentSnapshot json) =>
      MyUser(
        userId: json.id,
        name: json["name"],
        phone: json["phone"].toString().length == 11
            ? "${json["phone"].toString().substring(0, 1)} (${json["phone"].toString().substring(1, 4)}) ${json["phone"].toString().substring(4, 7)} ${json["phone"].toString().substring(7, 9)} ${json["phone"].toString().substring(9, 11)}"
            : json["phone"],
        isWorker: json["isWorker"],
        isAdmin: json["isAdmin"],
        isCustomer: json["isCustomer"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
