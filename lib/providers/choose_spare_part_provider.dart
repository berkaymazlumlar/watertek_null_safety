import 'package:flutter/cupertino.dart';
import 'package:teknoloji_kimya_servis/models/api_spare_part.dart';

class ChooseSparePartProvider with ChangeNotifier {
  List<ApiSparePartData> choosedSpareParts = [];

  void addOrRemoveSparePart(ApiSparePartData _apiSparePartData) {
    if (choosedSpareParts.contains(_apiSparePartData)) {
      choosedSpareParts.remove(_apiSparePartData);
    } else {
      choosedSpareParts.add(_apiSparePartData);
    }
    notifyListeners();
  }

  void clear() {
    choosedSpareParts.clear();
    notifyListeners();
  }
}
