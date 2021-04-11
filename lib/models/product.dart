import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<Product> userFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String userToJson(Product data) => json.encode(data.toJson());

class Product {
  String id;
  String productName;
  String productModel;
  DateTime createdAt;

  Product({
    this.id,
    this.productName,
    this.productModel,
    this.createdAt,
  });

  factory Product.fromJson(QueryDocumentSnapshot json) => Product(
      id: json.id,
      productName: json["name"] == null ? "İsim girilmemiş" : json["name"],
      productModel: json["model"],
      createdAt: DateTime.parse(json["createdAt"].toString()));

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "product_model": productModel,
      };
}
