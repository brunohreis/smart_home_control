import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { success, error, warning }

class UiToast {
  static void showToast(String message, ToastType type) {
    Color backgroundColor;

    // Define a cor de fundo com base no tipo de mensagem
    switch (type) {
      case ToastType.success:
        backgroundColor = Colors.green;
        break;
      case ToastType.error:
        backgroundColor = Colors.red;
        break;
      case ToastType.warning:
        backgroundColor = Colors.orange;
        break;
    }

    // Exibe o Toast com a cor e mensagem adequadas
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
