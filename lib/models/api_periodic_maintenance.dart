// To parse this JSON data, do
//
//     final apiPeriodicMaintenance = apiPeriodicMaintenanceFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApiPeriodicMaintenance apiPeriodicMaintenanceFromJson(String str) =>
    ApiPeriodicMaintenance.fromJson(json.decode(str));

String apiPeriodicMaintenanceToJson(ApiPeriodicMaintenance data) =>
    json.encode(data.toJson());

class ApiPeriodicMaintenance {
  ApiPeriodicMaintenance({
    @required this.count,
    @required this.body,
  });

  final int count;
  final List<ApiPeriodicMaintenanceData> body;

  factory ApiPeriodicMaintenance.fromJson(Map<String, dynamic> json) =>
      ApiPeriodicMaintenance(
        count: json["count"] == null ? null : json["count"],
        body: json["body"] == null
            ? null
            : List<ApiPeriodicMaintenanceData>.from(json["body"]
                .map((x) => ApiPeriodicMaintenanceData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "body": body == null
            ? null
            : List<dynamic>.from(body.map((x) => x.toJson())),
      };
}

class ApiPeriodicMaintenanceData {
  ApiPeriodicMaintenanceData({
    @required this.id,
    @required this.companyId,
    @required this.firstPeriodDate,
    @required this.companyName,
    @required this.period,
    @required this.createdAt,
    @required this.companyPhone,
    @required this.productCreatedAt,
  });

  final int id;
  final int companyId;
  final DateTime firstPeriodDate;
  final String companyName;
  final int period;
  final DateTime createdAt;
  final String companyPhone;
  final DateTime productCreatedAt;

  factory ApiPeriodicMaintenanceData.fromJson(Map<String, dynamic> json) =>
      ApiPeriodicMaintenanceData(
        id: json["id"] == null ? null : json["id"],
        companyId: json["companyId"] == null ? null : json["companyId"],
        firstPeriodDate: json["firstPeriodDate"] == null
            ? null
            : DateTime.parse(json["firstPeriodDate"]),
        companyName: json["companyName"],
        period: json["period"] == null ? null : json["period"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        companyPhone:
            json["companyPhone"] == null ? null : json["companyPhone"],
        productCreatedAt: json["productCreatedAt"] == null
            ? null
            : DateTime.parse(json["productCreatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "companyId": companyId == null ? null : companyId,
        "firstPeriodDate":
            firstPeriodDate == null ? null : firstPeriodDate.toIso8601String(),
        "companyName": companyName,
        "period": period == null ? null : period,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "companyPhone": companyPhone == null ? null : companyPhone,
        "productCreatedAt": productCreatedAt == null
            ? null
            : productCreatedAt.toIso8601String(),
      };
}
