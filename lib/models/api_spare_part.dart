// To parse this JSON data, do
//
//     final apiSparePart = apiSparePartFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApiSparePart apiSparePartFromJson(String str) =>
    ApiSparePart.fromJson(json.decode(str));

String apiSparePartToJson(ApiSparePart data) => json.encode(data.toJson());

class ApiSparePart {
  ApiSparePart({
    @required this.count,
    @required this.body,
  });

  final int count;
  final List<ApiSparePartData> body;

  factory ApiSparePart.fromJson(Map<String, dynamic> json) => ApiSparePart(
        count: json["count"] == null ? null : json["count"],
        body: json["body"] == null
            ? null
            : List<ApiSparePartData>.from(
                json["body"].map((x) => ApiSparePartData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "body": body == null
            ? null
            : List<dynamic>.from(body.map((x) => x.toJson())),
      };
}

class ApiSparePartData {
  ApiSparePartData({
    @required this.id,
    @required this.productId,
    @required this.name,
    @required this.count,
    @required this.createdAt,
    @required this.productName,
    @required this.productModel,
    @required this.productCreatedAt,
    @required this.price,
  });

  final int id;
  final int productId;
  final String name;
  final int count;
  final DateTime createdAt;
  final String productName;
  final String productModel;
  final DateTime productCreatedAt;
  final int price;

  factory ApiSparePartData.fromJson(Map<String, dynamic> json) =>
      ApiSparePartData(
        id: json["id"] == null ? null : json["id"],
        productId: json["productId"] == null ? null : json["productId"],
        name: json["name"] == null ? null : json["name"],
        count: json["count"] == null ? null : json["count"],
        price: json["price"] == null ? null : json["price"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        productName: json["productName"] == null ? null : json["productName"],
        productModel:
            json["productModel"] == null ? null : json["productModel"],
        productCreatedAt: json["productCreatedAt"] == null
            ? null
            : DateTime.parse(json["productCreatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "productId": productId == null ? null : productId,
        "name": name == null ? null : name,
        "count": count == null ? null : count,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "productName": productName == null ? null : productName,
        "productModel": productModel == null ? null : productModel,
        "productCreatedAt": productCreatedAt == null
            ? null
            : productCreatedAt.toIso8601String(),
      };
}
