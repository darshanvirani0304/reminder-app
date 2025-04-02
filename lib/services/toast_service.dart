import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastService {
  void showToastMessage({required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: const Color(0xFF404040),
      textColor: Colors.white,
    );
  }
}
