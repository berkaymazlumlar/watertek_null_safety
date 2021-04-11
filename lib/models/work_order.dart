import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<WorkOrder> userFromJson(String str) =>
    List<WorkOrder>.from(json.decode(str).map((x) => WorkOrder.fromJson(x)));

String userToJson(WorkOrder data) => json.encode(data.toJson());

class WorkOrder {
  String id;
  String companyName;
  String pdfUrl;
  String taskDescription;
  String workerName;
  String workerPhone;
  String companyPhone;
  DateTime taskDate;
  DateTime createdDate;

  WorkOrder(
      {this.id,
      this.taskDate,
      this.createdDate,
      this.companyName,
      this.companyPhone,
      this.pdfUrl,
      this.taskDescription,
      this.workerName,
      this.workerPhone});

  factory WorkOrder.fromJson(QueryDocumentSnapshot json) => WorkOrder(
        id: json.id,
        taskDate: DateTime.parse(json["task_date"]),
        createdDate: DateTime.parse(json["created_at"]),
        pdfUrl: json["pdf_url"],
        companyPhone: json["company_phone"],
        companyName: json["company_name"],
        workerName: json["worker_name"],
        workerPhone: json["worker_phone"],
        taskDescription: json["task_description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task_date": taskDate,
        "created_date": createdDate
      };
}
