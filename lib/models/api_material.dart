// To parse this JSON data, do
//
//     final apiMaterial = apiMaterialFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApiMaterial apiMaterialFromJson(String str) =>
    ApiMaterial.fromJson(json.decode(str));

String apiMaterialToJson(ApiMaterial data) => json.encode(data.toJson());

class ApiMaterial {
  ApiMaterial({
    @required this.count,
    @required this.body,
  });

  final int count;
  final List<ApiMaterialData> body;

  factory ApiMaterial.fromJson(Map<String, dynamic> json) => ApiMaterial(
        count: json["count"] == null ? null : json["count"],
        body: json["body"] == null
            ? null
            : List<ApiMaterialData>.from(
                json["body"].map((x) => ApiMaterialData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "body": body == null
            ? null
            : List<dynamic>.from(body.map((x) => x.toJson())),
      };
}

class ApiMaterialData {
  ApiMaterialData({
    @required this.id,
    @required this.materialName,
    @required this.materialPrice,
    @required this.materialModel,
    @required this.createdAt,
  });

  final int id;
  final String materialName;
  final int materialPrice;
  final String materialModel;
  final DateTime createdAt;

  factory ApiMaterialData.fromJson(Map<String, dynamic> json) =>
      ApiMaterialData(
        id: json["id"] == null ? null : json["id"],
        materialName:
            json["materialName"] == null ? null : json["materialName"],
        materialPrice:
            json["materialPrice"] == null ? null : json["materialPrice"],
        materialModel:
            json["materialModel"] == null ? null : json["materialModel"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "materialName": materialName == null ? null : materialName,
        "materialPrice": materialPrice == null ? null : materialPrice,
        "materialModel": materialModel == null ? null : materialModel,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
      };
}
