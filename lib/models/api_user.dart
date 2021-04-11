// To parse this JSON data, do
//
//     final apiUser = apiUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApiUser apiUserFromJson(String str) => ApiUser.fromJson(json.decode(str));

String apiUserToJson(ApiUser data) => json.encode(data.toJson());

class ApiUser {
  ApiUser({
    @required this.status,
    @required this.token,
    @required this.data,
  });

  final String status;
  final String token;
  final ApiUserData data;

  factory ApiUser.fromJson(Map<String, dynamic> json) => ApiUser(
        status: json["status"] == null ? null : json["status"],
        token: json["token"] == null ? null : json["token"],
        data: json["data"] == null ? null : ApiUserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "token": token == null ? null : token,
        "data": data == null ? null : data.toJson(),
      };
}

class ApiUserData {
  ApiUserData({
    @required this.id,
    @required this.username,
    @required this.password,
    @required this.isAdmin,
    @required this.isWorker,
    @required this.isCustomer,
    @required this.phone,
    @required this.createdAt,
    @required this.fullName,
  });

  final int id;
  final String username;
  final String password;
  final int isAdmin;
  final int isWorker;
  final int isCustomer;
  final String phone;
  final DateTime createdAt;
  final String fullName;

  factory ApiUserData.fromJson(Map<String, dynamic> json) => ApiUserData(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
        isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
        isWorker: json["isWorker"] == null ? null : json["isWorker"],
        isCustomer: json["isCustomer"] == null ? null : json["isCustomer"],
        phone: json["phone"] == null ? null : json["phone"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        fullName: json["fullName"] == null ? null : json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "password": password == null ? null : password,
        "isAdmin": isAdmin == null ? null : isAdmin,
        "isWorker": isWorker == null ? null : isWorker,
        "isCustomer": isCustomer == null ? null : isCustomer,
        "phone": phone == null ? null : phone,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
      };
}
