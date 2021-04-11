class NumberHelper {
  static bool isNumber(String item) {
    return '0123456789'.split('').contains(item);
  }

  static double getDoubleNumberFromString(String text) {
    String _number = "";
    for (var i = 0; i < text.length; i++) {
      if (isNumber(text[i])) {
        _number += text[i];
      }
    }
    if (_number.length == 0) {
      return 0.0;
    }
    return double.parse(_number);
  }

  static String getStringNumberFromString(String text) {
    String _number = "";
    for (var i = 0; i < text.length; i++) {
      if (isNumber(text[i])) {
        _number += text[i];
      }
    }
    return _number;
  }

  static String getFormattedNumberFromNumber(String number) {
    if (number.length != 10) {
      return "";
    }
    print(number);
    return "${number.substring(0, 3)}-${number.substring(3, 6)}-${number.substring(6, 10)}";
  }
}
