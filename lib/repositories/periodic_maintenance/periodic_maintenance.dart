import 'package:teknoloji_kimya_servis/api/get_apis.dart';
import 'package:teknoloji_kimya_servis/models/api_periodic_maintenance.dart';

class PeriodicMaintenanceRepository {
  ApiPeriodicMaintenance _periodicMaintenance;

  ApiPeriodicMaintenance get periodicMaintenance => _periodicMaintenance;

  set periodicMaintenance(ApiPeriodicMaintenance periodicMaintenance) {
    _periodicMaintenance = periodicMaintenance;
  }

  Future<ApiPeriodicMaintenance> getPeriodicMaintenance(
      {String search, int customerId}) async {
    final _response = await GetApi.getPeriodicMaintenance(
        search: search, customerId: customerId);
    if (_response is ApiPeriodicMaintenance) {
      periodicMaintenance = _response;
      return periodicMaintenance;
    }
    return null;
  }

  // Future<List<PeriodicMaintenance>> getPeriodicMaintenanceList() async {
  //   final List<PeriodicMaintenance> _myPeriodicMaintenances = [];

  //   final _response =
  //       await FirebaseFirestore.instance.collection('periodic_maintenance').get();
  //   for (var item in _response.docs) {
  //     print(item.data());
  //     _myPeriodicMaintenances.add(PeriodicMaintenance.fromJson(item));
  //   }
  //   this._myPeriodicMaintenances.addAll(_myPeriodicMaintenances);
  //   return _myPeriodicMaintenances;
  // }
}
