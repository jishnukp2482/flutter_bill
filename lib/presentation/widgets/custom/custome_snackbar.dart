import 'package:flutter/material.dart';
import 'package:flashy_flushbar/flashy_flushbar.dart';
import 'package:flutter_bill/presentation/themes/app_colors.dart';

void bottomMsg(String title, String msg, bool field) {
  FlashyFlushbar(
    backgroundColor: field == false ? AppColors.red : AppColors.green,
    leadingWidget: Icon(
      field == false ? Icons.error_outline : Icons.check_circle_outline,
      color: Colors.white,
      size: 24,
    ),
    message: msg,
    trailingWidget: IconButton(
      icon: Icon(
        Icons.close,
        color: Colors.white,
        size: 24,
      ),
      onPressed: () {
        FlashyFlushbar.cancel();
      },
    ),
    messageStyle: TextStyle(
      fontWeight: FontWeight.w500,
      color: AppColors.white,
      fontSize: 16,
    ),
    duration: const Duration(seconds: 3),
    dismissDirection: DismissDirection.horizontal,
    isDismissible: true,
  ).show();
}
