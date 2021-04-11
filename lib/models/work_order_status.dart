import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<WorkOrderStatus> userFromJson(String str) => List<WorkOrderStatus>.from(
    json.decode(str).map((x) => WorkOrderStatus.fromJson(x)));

class WorkOrderStatus {
  String id;
  String workStatus;
  String workOrderId;
  String workerName;
  String workerPhone;
  DateTime createdAt;

  WorkOrderStatus({
    this.id,
    this.createdAt,
    this.workStatus,
    this.workOrderId,
    this.workerName,
    this.workerPhone,
  });

  factory WorkOrderStatus.fromJson(QueryDocumentSnapshot json) => WorkOrderStatus(
        id: json.id,
        createdAt: DateTime.parse(json["created_at"]),
        workOrderId: json["work_order_id"],
        workStatus: json["work_status"],
        workerName: json["worker_name"],
        workerPhone: json["worker_phone"],
      );
}
