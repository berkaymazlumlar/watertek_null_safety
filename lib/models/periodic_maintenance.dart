import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<PeriodicMaintenance> userFromJson(String str) =>
    List<PeriodicMaintenance>.from(
        json.decode(str).map((x) => PeriodicMaintenance.fromJson(x)));

String userToJson(PeriodicMaintenance data) => json.encode(data.toJson());

class PeriodicMaintenance {
  String id;
  String companyId;
  String companyName;
  String companyPhone;
  DateTime createdAt;
  int period;
  DateTime firstPeriodDate;

  PeriodicMaintenance(
      {this.id,
      this.companyId,
      this.period,
      this.firstPeriodDate,
      this.companyName,
      this.companyPhone,
      this.createdAt});

  factory PeriodicMaintenance.fromJson(QueryDocumentSnapshot json) =>
      PeriodicMaintenance(
        id: json.id,
        companyId: json["company_id"],
        companyName: json["company_name"],
        companyPhone: json["company_phone"],
        createdAt: DateTime.parse(json["created_at"].toString()),
        period: int.parse(json["period"]),
        firstPeriodDate: DateTime.parse(json["first_period_date"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "period": period,
        "first_period_date": firstPeriodDate,
      };
}
