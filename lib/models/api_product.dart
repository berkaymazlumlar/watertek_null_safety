// To parse this JSON data, do
//
//     final apiProduct = apiProductFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApiProduct apiProductFromJson(String str) =>
    ApiProduct.fromJson(json.decode(str));

String apiProductToJson(ApiProduct data) => json.encode(data.toJson());

class ApiProduct {
  ApiProduct({
    @required this.count,
    @required this.body,
  });

  final int count;
  final List<ApiProductData> body;

  factory ApiProduct.fromJson(Map<String, dynamic> json) => ApiProduct(
        count: json["count"] == null ? null : json["count"],
        body: json["body"] == null
            ? null
            : List<ApiProductData>.from(
                json["body"].map((x) => ApiProductData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "body": body == null
            ? null
            : List<dynamic>.from(body.map((x) => x.toJson())),
      };
}

class ApiProductData {
  ApiProductData({
    @required this.id,
    @required this.name,
    @required this.model,
    @required this.createdAt,
  });

  final int id;
  final String name;
  final String model;
  final DateTime createdAt;

  factory ApiProductData.fromJson(Map<String, dynamic> json) => ApiProductData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        model: json["model"] == null ? null : json["model"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "model": model == null ? null : model,
      };
}
