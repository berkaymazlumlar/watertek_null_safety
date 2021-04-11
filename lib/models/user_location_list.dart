import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<UserLocationList> userFromJson(String str) => List<UserLocationList>.from(
    json.decode(str).map((x) => UserLocationList.fromJson(x)));

String userToJson(UserLocationList data) => json.encode(data.toJson());

class UserLocationList {
  UserLocationList({
    this.name,
    this.id,
    this.phone,
    this.lat,
    this.lng,
    this.updatedAt,
  });

  String id;
  String name;
  String phone;
  String lat;
  String lng;
  DateTime updatedAt;

  factory UserLocationList.fromJson(QueryDocumentSnapshot json) =>
      UserLocationList(
        id: json.id,
        name: json["name"],
        phone: json["phone"].toString().length == 11
            ? "${json["phone"].toString().substring(0, 1)} (${json["phone"].toString().substring(1, 4)}) ${json["phone"].toString().substring(4, 7)} ${json["phone"].toString().substring(7, 9)} ${json["phone"].toString().substring(9, 11)}"
            : json["phone"],
        lat: json["lat"],
        lng: json["lng"],
        updatedAt: DateTime.parse(json["updatedAt"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
