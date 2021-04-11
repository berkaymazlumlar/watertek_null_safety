import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

class MyFlushbarHelper {
  MyFlushbarHelper({@required this.context});
  final BuildContext context;
  void showErrorFlushbar({String title, String message}) {
    FlushbarHelper.createError(
      message: "$message",
      title: "$title",
    )..show(context);
  }

  void showInfoFlushbar({String title, String message}) {
    FlushbarHelper.createInformation(
      message: "$message",
      title: "$title",
    )..show(context);
  }

  void showSuccessFlushbar({String title, String message}) {
    FlushbarHelper.createSuccess(
      message: "$message",
      title: "$title",
    )..show(context);
  }
}
