import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<SparePart> userFromJson(String str) =>
    List<SparePart>.from(json.decode(str).map((x) => SparePart.fromJson(x)));

String userToJson(SparePart data) => json.encode(data.toJson());

class SparePart {
  String id;
  String productId;
  String productName;
  String productModel;
  String sparePartName;
  String sparePartPrice;

  SparePart({
    this.productName,
    this.productModel,
    this.sparePartPrice,
    this.id,
    this.productId,
    this.sparePartName,
  });

  factory SparePart.fromJson(QueryDocumentSnapshot json) => SparePart(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        productModel: json["product_model"],
        sparePartName: json["spare_part_name"],
        sparePartPrice: json["spare_part_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "product_model": productModel,
        "spare_part_name": sparePartName,
        "spare_part_price": sparePartPrice,
      };
}
