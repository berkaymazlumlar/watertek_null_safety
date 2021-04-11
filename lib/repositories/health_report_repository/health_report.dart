import 'package:teknoloji_kimya_servis/api/get_apis.dart';
import 'package:teknoloji_kimya_servis/models/api_health_report.dart';

class HealthReportRepository {
  ApiHealthReport _healthReport;

  ApiHealthReport get healthReport => _healthReport;

  set healthReport(ApiHealthReport healthReport) {
    _healthReport = healthReport;
  }

  Future<ApiHealthReport> getHealthReport() async {
    final _response = await GetApi.getHealthReport();
    if (_response is ApiHealthReport) {
      healthReport = _response;
      return healthReport;
    }
    return null;
  }

  // Future<List<HealthReport>> getHealthReportList() async {
  //   final List<HealthReport> _myHealthReports = [];

  //   final _response =
  //       await FirebaseFirestore.instance.collection('periodic_maintenance').get();
  //   for (var item in _response.docs) {
  //     print(item.data());
  //     _myHealthReports.add(HealthReport.fromJson(item));
  //   }
  //   this._myHealthReports.addAll(_myHealthReports);
  //   return _myHealthReports;
  // }
}
