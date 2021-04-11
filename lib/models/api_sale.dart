// To parse this JSON data, do
//
//     final apiSale = apiSaleFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApiSale apiSaleFromJson(String str) => ApiSale.fromJson(json.decode(str));

String apiSaleToJson(ApiSale data) => json.encode(data.toJson());

class ApiSale {
  ApiSale({
    @required this.status,
    @required this.data,
  });

  final String status;
  final List<ApiSaleData> data;

  factory ApiSale.fromJson(Map<String, dynamic> json) => ApiSale(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : List<ApiSaleData>.from(
                json["data"].map((x) => ApiSaleData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ApiSaleData {
  ApiSaleData({
    @required this.departman,
    @required this.lokasyon,
    @required this.id,
    @required this.companyId,
    @required this.productId,
    @required this.setupDate,
    @required this.warrantyDate,
    @required this.barcode,
    @required this.createdAt,
    @required this.productName,
    @required this.productModel,
    @required this.companyName,
    @required this.companyPhone,
  });

  final int id;
  final int companyId;
  final int productId;
  final DateTime setupDate;
  final DateTime warrantyDate;
  final String barcode;
  final DateTime createdAt;
  final String productName;
  final String productModel;
  final String companyName;
  final String companyPhone;
  final String departman;
  final String lokasyon;

  factory ApiSaleData.fromJson(Map<String, dynamic> json) => ApiSaleData(
        id: json["id"] == null ? null : json["id"],
        companyId: json["companyId"] == null ? null : json["companyId"],
        productId: json["productId"] == null ? null : json["productId"],
        setupDate: json["setupDate"] == null
            ? null
            : DateTime.parse(json["setupDate"]),
        warrantyDate: json["warrantyDate"] == null
            ? null
            : DateTime.parse(json["warrantyDate"]),
        barcode: json["barcode"] == null ? null : json["barcode"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        productName: json["productName"] == null ? null : json["productName"],
        productModel:
            json["productModel"] == null ? null : json["productModel"],
        departman: json["departman"] == null ? null : json["departman"],
        lokasyon: json["lokasyon"] == null ? null : json["lokasyon"],
        companyName: json["companyName"] == null ? null : json["companyName"],
        companyPhone:
            json["companyPhone"] == null ? null : json["companyPhone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "companyId": companyId == null ? null : companyId,
        "productId": productId == null ? null : productId,
        "setupDate": setupDate == null ? null : setupDate.toIso8601String(),
        "warrantyDate":
            warrantyDate == null ? null : warrantyDate.toIso8601String(),
        "barcode": barcode == null ? null : barcode,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "productName": productName == null ? null : productName,
        "productModel": productModel == null ? null : productModel,
        "lokasyon": lokasyon == null ? null : lokasyon,
        "departman": departman == null ? null : departman,
        "companyName": companyName == null ? null : companyName,
        "companyPhone": companyPhone == null ? null : companyPhone,
      };
}
