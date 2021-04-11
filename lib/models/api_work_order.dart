// To parse this JSON data, do
//
//     final apiWorkOrder = apiWorkOrderFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApiWorkOrder apiWorkOrderFromJson(String str) =>
    ApiWorkOrder.fromJson(json.decode(str));

String apiWorkOrderToJson(ApiWorkOrder data) => json.encode(data.toJson());

class ApiWorkOrder {
  ApiWorkOrder({
    @required this.status,
    @required this.data,
  });

  final String status;
  final List<ApiWorkOrderData> data;

  factory ApiWorkOrder.fromJson(Map<String, dynamic> json) => ApiWorkOrder(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : List<ApiWorkOrderData>.from(
                json["data"].map((x) => ApiWorkOrderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ApiWorkOrderData {
  ApiWorkOrderData({
    @required this.id,
    @required this.companyId,
    @required this.userId,
    @required this.pdfUrl,
    @required this.taskDate,
    @required this.taskDescription,
    @required this.createdAt,
    @required this.companyName,
    @required this.companyPhone,
    @required this.userFullName,
    @required this.isAdmin,
    @required this.isWorker,
    @required this.isCustomer,
    @required this.userPhone,
  });

  final int id;
  final int companyId;
  final int userId;
  final String pdfUrl;
  final DateTime taskDate;
  final String taskDescription;
  final DateTime createdAt;
  final String companyName;
  final String companyPhone;
  final String userFullName;
  final int isAdmin;
  final int isWorker;
  final int isCustomer;
  final String userPhone;

  factory ApiWorkOrderData.fromJson(Map<String, dynamic> json) =>
      ApiWorkOrderData(
        id: json["id"] == null ? null : json["id"],
        companyId: json["companyId"] == null ? null : json["companyId"],
        userId: json["userId"] == null ? null : json["userId"],
        pdfUrl: json["pdfUrl"] == null ? null : json["pdfUrl"],
        taskDate:
            json["taskDate"] == null ? null : DateTime.parse(json["taskDate"]),
        taskDescription:
            json["taskDescription"] == null ? null : json["taskDescription"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
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
        "companyId": companyId == null ? null : companyId,
        "userId": userId == null ? null : userId,
        "pdfUrl": pdfUrl == null ? null : pdfUrl,
        "taskDate": taskDate == null ? null : taskDate.toIso8601String(),
        "taskDescription": taskDescription == null ? null : taskDescription,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "companyName": companyName == null ? null : companyName,
        "companyPhone": companyPhone == null ? null : companyPhone,
        "userFullName": userFullName == null ? null : userFullName,
        "isAdmin": isAdmin == null ? null : isAdmin,
        "isWorker": isWorker == null ? null : isWorker,
        "isCustomer": isCustomer == null ? null : isCustomer,
        "userPhone": userPhone == null ? null : userPhone,
      };
}
