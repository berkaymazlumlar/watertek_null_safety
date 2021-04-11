import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teknoloji_kimya_servis/api/get_apis.dart';
import 'package:teknoloji_kimya_servis/models/api_service_report.dart';
import 'package:teknoloji_kimya_servis/models/service_report.dart';

class ServiceReportRepository {
  ApiServiceReport _apiServiceReport;

  ApiServiceReport get apiServiceReport => _apiServiceReport;

  set apiServiceReport(ApiServiceReport apiServiceReport) {
    _apiServiceReport = apiServiceReport;
  }

  Future<ApiServiceReport> getServiceReport({String search}) async {
    final _response = await GetApi.getServiceReport(search: search);
    if (_response != null) {
      _apiServiceReport = _response;
      return _response;
    } else {
      return null;
    }
  }

  // Future<List<ApiServiceReport>> getApiServiceReportList() async {
  //   final List<ApiServiceReport> _myApiServiceReports = [];

  //   final _response =
  //       await FirebaseFirestore.instance.collection('service_report').get();
  //   for (var item in _response.docs) {
  //     print(item.data());
  //     _myApiServiceReports.add(ApiServiceReport.fromJson(item));
  //   }
  //   this._myApiServiceReports.addAll(_myApiServiceReports);
  //   return _myApiServiceReports;
  // }
}
