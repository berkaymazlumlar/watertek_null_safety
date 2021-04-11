import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<Sale> userFromJson(String str) =>
    List<Sale>.from(json.decode(str).map((x) => Sale.fromJson(x)));

String userToJson(Sale data) => json.encode(data.toJson());

class Sale {
  String id;
  String productName;
  String barcode;
  String companyId;
  String productModel;
  DateTime setupDate;
  DateTime warrantyDate;
  DateTime createdAt;
  String companyName;

  Sale({
    this.id,
    this.productName,
    this.barcode,
    this.companyId,
    this.productModel,
    this.setupDate,
    this.warrantyDate,
    this.createdAt,
    this.companyName,
  });

  factory Sale.fromJson(QueryDocumentSnapshot json) => Sale(
        id: json.id,
        productName: json["product_name"] == null
            ? "İsim girilmemiş"
            : json["product_name"],
        barcode: json["barcode"] == null ? "Qr yok" : json["barcode"],
        companyId: json["company_id"],
        productModel: json["product_model"],
        companyName: json["company_name"],
        setupDate: DateTime.parse(json["setup_date"]),
        warrantyDate: DateTime.parse(json["warranty_date"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "barcode": barcode,
        "company_id": companyId,
        "model": productModel,
        "setup_date": setupDate,
        "warranty_date": warrantyDate,
      };
}
