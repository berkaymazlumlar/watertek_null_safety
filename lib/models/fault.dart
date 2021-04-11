import 'dart:convert';

List<Fault> userFromJson(String str) =>
    List<Fault>.from(json.decode(str).map((x) => Fault.fromJson(x)));

String userToJson(Fault data) => json.encode(data.toJson());

class Fault {
  String id;
  String productId;
  String title;
  String description;
  DateTime date;

  Fault({this.id, this.productId, this.title, this.date, this.description});

  factory Fault.fromJson(Map<String, dynamic> json) => Fault(
        id: json["id"],
        productId: json["product_id"],
        title: json["title"],
        date: json["date"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "title": title,
        "date": date,
        "description": description,
      };
}
