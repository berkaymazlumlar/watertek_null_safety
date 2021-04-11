// To parse this JSON data, do
//
//     final apiCustomerRequest = apiCustomerRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApiCustomerRequest apiCustomerRequestFromJson(String str) =>
    ApiCustomerRequest.fromJson(json.decode(str));

String apiCustomerRequestToJson(ApiCustomerRequest data) =>
    json.encode(data.toJson());

class ApiCustomerRequest {
  ApiCustomerRequest({
    @required this.count,
    @required this.body,
  });

  final int count;
  final List<ApiCustomerRequestData> body;

  factory ApiCustomerRequest.fromJson(Map<String, dynamic> json) =>
      ApiCustomerRequest(
        count: json["count"] == null ? null : json["count"],
        body: json["body"] == null
            ? null
            : List<ApiCustomerRequestData>.from(
                json["body"].map((x) => ApiCustomerRequestData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "body": body == null
            ? null
            : List<dynamic>.from(body.map((x) => x.toJson())),
      };
}

class ApiCustomerRequestData {
  ApiCustomerRequestData({
    @required this.id,
    @required this.videoUrl,
    @required this.description,
    @required this.userId,
    @required this.title,
    @required this.createdAt,
    @required this.userFullname,
    @required this.userphone,
  });

  final int id;
  final String videoUrl;
  final String description;
  final int userId;
  final String title;
  final DateTime createdAt;
  final String userFullname;
  final String userphone;

  factory ApiCustomerRequestData.fromJson(Map<String, dynamic> json) =>
      ApiCustomerRequestData(
        id: json["id"] == null ? null : json["id"],
        videoUrl: json["videoUrl"] == null ? null : json["videoUrl"],
        description: json["description"] == null ? null : json["description"],
        userId: json["userId"] == null ? null : json["userId"],
        title: json["title"] == null ? null : json["title"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        userFullname:
            json["userFullname"] == null ? null : json["userFullname"],
        userphone: json["userphone"] == null ? null : json["userphone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "videoUrl": videoUrl == null ? null : videoUrl,
        "description": description == null ? null : description,
        "userId": userId == null ? null : userId,
        "title": title == null ? null : title,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "userFullname": userFullname == null ? null : userFullname,
        "userphone": userphone == null ? null : userphone,
      };
}
