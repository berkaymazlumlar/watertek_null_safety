// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApiCompany apiCompanyFromJson(String str) =>
    ApiCompany.fromJson(json.decode(str));

String apiCompanyToJson(ApiCompany data) => json.encode(data.toJson());

class ApiCompany {
  ApiCompany({
    @required this.count,
    @required this.body,
  });

  final int count;
  final List<ApiCompanyData> body;

  factory ApiCompany.fromJson(Map<String, dynamic> json) => ApiCompany(
        count: json["count"] == null ? null : json["count"],
        body: json["body"] == null
            ? null
            : List<ApiCompanyData>.from(
                json["body"].map((x) => ApiCompanyData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "body": body == null
            ? null
            : List<dynamic>.from(body.map((x) => x.toJson())),
      };
}

class ApiCompanyData {
  ApiCompanyData({
    @required this.id,
    @required this.name,
    @required this.phone,
    @required this.createdAt,
  });

  final int id;
  final String name;
  final String phone;
  final DateTime createdAt;

  factory ApiCompanyData.fromJson(Map<String, dynamic> json) => ApiCompanyData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
      };
}
