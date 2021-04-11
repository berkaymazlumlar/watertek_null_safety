import 'package:teknoloji_kimya_servis/api/get_apis.dart';
import 'package:teknoloji_kimya_servis/models/api_health_report.dart';
import 'package:teknoloji_kimya_servis/models/api_material.dart';
import 'package:teknoloji_kimya_servis/models/api_work_code.dart';

class MaterialRepository {
  ApiMaterial _material;

  ApiMaterial get material => _material;

  set material(ApiMaterial material) {
    _material = material;
  }

  Future<ApiMaterial> getMaterial() async {
    final _response = await GetApi.getMaterial();
    if (_response is ApiMaterial) {
      material = _response;
      return material;
    }
    return null;
  }
}
