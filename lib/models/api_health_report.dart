// To parse this JSON data, do
//
//     final apiHealthReport = apiHealthReportFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApiHealthReport apiHealthReportFromJson(String str) =>
    ApiHealthReport.fromJson(json.decode(str));

String apiHealthReportToJson(ApiHealthReport data) =>
    json.encode(data.toJson());

class ApiHealthReport {
  ApiHealthReport({
    @required this.count,
    @required this.body,
  });

  final int count;
  final List<HealthReportData> body;

  factory ApiHealthReport.fromJson(Map<String, dynamic> json) =>
      ApiHealthReport(
        count: json["count"] == null ? null : json["count"],
        body: json["body"] == null
            ? null
            : List<HealthReportData>.from(
                json["body"].map((x) => HealthReportData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "body": body == null
            ? null
            : List<dynamic>.from(body.map((x) => x.toJson())),
      };
}

class HealthReportData {
  HealthReportData({
    @required this.id,
    @required this.userId,
    @required this.startDate,
    @required this.expirationDate,
    @required this.createdAt,
    @required this.workerName,
    @required this.workerPhone,
  });

  final int id;
  final int userId;
  final DateTime startDate;
  final DateTime expirationDate;
  final DateTime createdAt;
  final String workerName;
  final String workerPhone;

  factory HealthReportData.fromJson(Map<String, dynamic> json) =>
      HealthReportData(
        id: json["id"] == null ? null : json["id"],
        userId: json["userId"] == null ? null : json["userId"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        expirationDate: json["expirationDate"] == null
            ? null
            : DateTime.parse(json["expirationDate"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        workerName: json["workerName"] == null ? null : json["workerName"],
        workerPhone: json["workerPhone"] == null ? null : json["workerPhone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "userId": userId == null ? null : userId,
        "startDate": startDate == null ? null : startDate.toIso8601String(),
        "expirationDate":
            expirationDate == null ? null : expirationDate.toIso8601String(),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "workerName": workerName == null ? null : workerName,
        "workerPhone": workerPhone == null ? null : workerPhone,
      };
}
