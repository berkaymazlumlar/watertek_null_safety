import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class SignProvider with ChangeNotifier {
  Uint8List _workerSign;
  Uint8List get workerSign => _workerSign;
  set workerSign(Uint8List workerSign) {
    _workerSign = workerSign;
    notifyListeners();
  }

  Uint8List _customerSign;
  Uint8List get customerSign => _customerSign;
  set customerSign(Uint8List customerSign) {
    _customerSign = customerSign;
    notifyListeners();
  }
}
