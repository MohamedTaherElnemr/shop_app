import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String? message;
Color? color;

void showMessage({required String message, required ToastState state}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16);

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color? color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;

    case ToastState.ERROR:
      color = Colors.red;
      break;

    case ToastState.WARNING:
      color = Colors.orange;
      break;
  }

  return color;
}
