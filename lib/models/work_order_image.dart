import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<WorkOrderImage> userFromJson(String str) => List<WorkOrderImage>.from(
    json.decode(str).map((x) => WorkOrderImage.fromJson(x)));

class WorkOrderImage {
  String id;
  String imagePath;
  String workOrderId;
  String workerName;
  String workerPhone;
  DateTime createdAt;

  WorkOrderImage({
    this.id,
    this.createdAt,
    this.imagePath,
    this.workOrderId,
    this.workerName,
    this.workerPhone,
  });

  factory WorkOrderImage.fromJson(QueryDocumentSnapshot json) => WorkOrderImage(
        id: json.id,
        createdAt: DateTime.parse(json["created_at"]),
        workOrderId: json["work_order_id"],
        imagePath: json["image_path"],
        workerName: json["worker_name"],
        workerPhone: json["worker_phone"],
      );
}
