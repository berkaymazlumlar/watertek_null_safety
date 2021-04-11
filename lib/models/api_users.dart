// To parse this JSON data, do
//
//     final apiUsers = apiUsersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApiUsers apiUsersFromJson(String str) => ApiUsers.fromJson(json.decode(str));
ApiUsers apiUsersFromJsonRequestPage(String str) =>
    ApiUsers.fromJsonRequestPage(json.decode(str));

String apiUsersToJson(ApiUsers data) => json.encode(data.toJson());

class ApiUsers {
  ApiUsers({
    @required this.count,
    @required this.body,
  });

  final int count;
  final List<ApiUsersData> body;

  factory ApiUsers.fromJson(Map<String, dynamic> json) => ApiUsers(
        count: json["count"] == null ? null : json["count"],
        body: json["body"] == null
            ? "null"
            : List<ApiUsersData>.from(
                json["body"].map((x) => ApiUsersData.fromJson(x))),
      );

  factory ApiUsers.fromJsonRequestPage(Map<String, dynamic> json) => ApiUsers(
        count: json["count"] == null ? null : json["count"],
        body: json["data"] == null
            ? null
            : List<ApiUsersData>.from(
                json["data"].map((x) => ApiUsersData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "body": body == null
            ? null
            : List<dynamic>.from(body.map((x) => x.toJson())),
      };
}

class ApiUsersData {
  ApiUsersData({
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

  factory ApiUsersData.fromJson(Map<String, dynamic> json) => ApiUsersData(
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
        "fullName": fullName == null ? null : fullName,
      };
}
