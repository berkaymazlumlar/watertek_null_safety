import 'package:flutter/material.dart';

class NavigatorHelper {
  final BuildContext context;

  NavigatorHelper(this.context);

  void goTo(Widget to) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => to,
      ),
    );
  }
}
