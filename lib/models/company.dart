import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<Company> userFromJson(String str) =>
    List<Company>.from(json.decode(str).map((x) => Company.fromJson(x)));

String userToJson(Company data) => json.encode(data.toJson());

class Company {
  Company({this.name, this.id, this.phone});

  String id;
  String name;
  String phone;

  factory Company.fromJson(QueryDocumentSnapshot json) => Company(
        id: json.id,
        name: json["name"],
        phone: json["phone"].toString().length == 11
            ? "${json["phone"].toString().substring(0, 1)} (${json["phone"].toString().substring(1, 4)}) ${json["phone"].toString().substring(4, 7)} ${json["phone"].toString().substring(7, 9)} ${json["phone"].toString().substring(9, 11)}"
            : json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
