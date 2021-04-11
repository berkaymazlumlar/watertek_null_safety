import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/api/get_apis.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_work_order.dart';
import 'package:teknoloji_kimya_servis/models/work_order.dart';

class WorkOrderRepository {
  ApiWorkOrder _apiWorkOrder;

  ApiWorkOrder get apiWorkOrder => _apiWorkOrder;

  set apiWorkOrder(ApiWorkOrder apiWorkOrder) {
    _apiWorkOrder = apiWorkOrder;
  }

  ApiWorkOrderData _apiWorkOrderData;

  ApiWorkOrderData get apiWorkOrderData => _apiWorkOrderData;

  set apiWorkOrderData(ApiWorkOrderData apiWorkOrderData) {
    _apiWorkOrderData = apiWorkOrderData;
  }

  Future<ApiWorkOrder> getApiWorkOrder({String search, int workerId}) async {
    final _response =
        await GetApi.getWorkOrder(search: search, workerId: workerId);
    print("response: $_response");
    if (_response is ApiWorkOrder) {
      apiWorkOrder = _response;
      return apiWorkOrder;
    }
    return null;
  }

  final List<WorkOrder> _myWorkOrders = [];
  WorkOrder _choosedWorkOrder;
  WorkOrder get workOrder => _choosedWorkOrder;
  set workOrder(WorkOrder workOrder) {
    _choosedWorkOrder = workOrder;
  }

  Future<List<WorkOrder>> getWorkOrderList() async {
    final List<WorkOrder> _myWorkOrders = [];

    final _response =
        await FirebaseFirestore.instance.collection('work_order').get();
    for (var item in _response.docs) {
      print(item.data());
      _myWorkOrders.add(WorkOrder.fromJson(item));
    }
    this._myWorkOrders.addAll(_myWorkOrders);
    return _myWorkOrders;
  }
}
