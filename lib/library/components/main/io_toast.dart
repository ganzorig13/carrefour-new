import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carrefour/library/library.dart';

class IOToast {
  final String text;
  final Color? backgroundColor;
  final ToastGravity? gravity;
  final int? time;

  IOToast({
    required this.text,
    this.backgroundColor,
    this.gravity,
    this.time,
  });

  void show() {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      timeInSecForIosWeb: time ?? 1,
      backgroundColor: backgroundColor ?? IOColors.brand400,
      textColor: IOColors.backgroundPrimary,
      fontSize: 16,
    );
  }
}
