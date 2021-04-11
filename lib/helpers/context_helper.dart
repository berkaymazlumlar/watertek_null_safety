import 'dart:developer';

import 'package:flutter/cupertino.dart';

class ContextHelper {
  static final ContextHelper _singleton = ContextHelper._internal();

  factory ContextHelper() {
    return _singleton;
  }

  ContextHelper._internal();

  BuildContext _context;

  BuildContext get context => _context;

  set context(BuildContext context) {
    _context = context;
    log("ContextHelper context setted");
  }
}
