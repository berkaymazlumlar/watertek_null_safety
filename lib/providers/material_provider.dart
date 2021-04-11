import 'package:flutter/cupertino.dart';
import 'package:teknoloji_kimya_servis/models/api_material.dart';

class ChooseMaterialProvider with ChangeNotifier {
  List<ApiMaterialData> choosedMaterials = [];

  void addOrRemoveMaterial(ApiMaterialData _apiMaterialData) {
    if (choosedMaterials.contains(_apiMaterialData)) {
      choosedMaterials.remove(_apiMaterialData);
    } else {
      choosedMaterials.add(_apiMaterialData);
    }
    notifyListeners();
  }

  void clear() {
    choosedMaterials.clear();
    notifyListeners();
  }
}
