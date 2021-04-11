// To parse this JSON data, do
//
//     final apiWorkCode = apiWorkCodeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApiWorkCode apiWorkCodeFromJson(String str) =>
    ApiWorkCode.fromJson(json.decode(str));

String apiWorkCodeToJson(ApiWorkCode data) => json.encode(data.toJson());

class ApiWorkCode {
  ApiWorkCode({
    @required this.status,
    @required this.data,
  });

  final String status;
  final List<ApiWorkCodeData> data;

  factory ApiWorkCode.fromJson(Map<String, dynamic> json) => ApiWorkCode(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : List<ApiWorkCodeData>.from(
                json["data"].map((x) => ApiWorkCodeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ApiWorkCodeData {
  ApiWorkCodeData({
    @required this.id,
    @required this.workerId,
    @required this.customerId,
    @required this.department,
    @required this.startDate,
    @required this.expirationDate,
    @required this.createdAt,
    @required this.workCode,
    @required this.companyName,
    @required this.companyPhone,
    @required this.userFullName,
    @required this.isAdmin,
    @required this.isWorker,
    @required this.isCustomer,
    @required this.userPhone,
  });

  final int id;
  final int workerId;
  final int customerId;
  final String department;
  final DateTime startDate;
  final DateTime expirationDate;
  final DateTime createdAt;
  final dynamic workCode;
  final String companyName;
  final String companyPhone;
  final String userFullName;
  final int isAdmin;
  final int isWorker;
  final int isCustomer;
  final String userPhone;

  factory ApiWorkCodeData.fromJson(Map<String, dynamic> json) =>
      ApiWorkCodeData(
        id: json["id"] == null ? null : json["id"],
        workerId: json["workerId"] == null ? null : json["workerId"],
        customerId: json["customerId"] == null ? null : json["customerId"],
        department: json["department"] == null ? null : json["department"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        expirationDate: json["expirationDate"] == null
            ? null
            : DateTime.parse(json["expirationDate"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        workCode: json["workCode"],
        companyName: json["companyName"] == null ? null : json["companyName"],
        companyPhone:
            json["companyPhone"] == null ? null : json["companyPhone"],
        userFullName:
            json["userFullName"] == null ? null : json["userFullName"],
        isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
        isWorker: json["isWorker"] == null ? null : json["isWorker"],
        isCustomer: json["isCustomer"] == null ? null : json["isCustomer"],
        userPhone: json["userPhone"] == null ? null : json["userPhone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "workerId": workerId == null ? null : workerId,
        "customerId": customerId == null ? null : customerId,
        "department": department == null ? null : department,
        "startDate": startDate == null ? null : startDate.toIso8601String(),
        "expirationDate":
            expirationDate == null ? null : expirationDate.toIso8601String(),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "workCode": workCode,
        "companyName": companyName == null ? null : companyName,
        "companyPhone": companyPhone == null ? null : companyPhone,
        "userFullName": userFullName == null ? null : userFullName,
        "isAdmin": isAdmin == null ? null : isAdmin,
        "isWorker": isWorker == null ? null : isWorker,
        "isCustomer": isCustomer == null ? null : isCustomer,
        "userPhone": userPhone == null ? null : userPhone,
      };
}
