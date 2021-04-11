import 'package:teknoloji_kimya_servis/api/get_apis.dart';
import 'package:teknoloji_kimya_servis/models/api_health_report.dart';
import 'package:teknoloji_kimya_servis/models/api_work_code.dart';

class WorkCodeRepository {
  ApiWorkCode _workCode;

  ApiWorkCode get workCode => _workCode;

  set workCode(ApiWorkCode workCode) {
    _workCode = workCode;
  }

  Future<ApiWorkCode> getWorkCode() async {
    final _response = await GetApi.getWorkCode();
    if (_response is ApiWorkCode) {
      workCode = _response;
      return workCode;
    }
    return null;
  }
}
