import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<ServiceReport> userFromJson(String str) => List<ServiceReport>.from(
    json.decode(str).map((x) => ServiceReport.fromJson(x)));

String userToJson(ServiceReport data) => json.encode(data.toJson());

class ServiceReport {
  ServiceReport({
    this.id,
    this.pdfPath,
  });

  String id;
  String pdfPath;
  String reportType;

  factory ServiceReport.fromJson(QueryDocumentSnapshot json) => ServiceReport(
        id: json.id,
        pdfPath: json["pdf_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pdf_path": pdfPath,
      };
}
