import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../utils/colors.dart';
import 'custom_text.dart';

void showToastificationWidget({
  required String message,
  required BuildContext context,
  ToastificationType notificationType = ToastificationType.error,
  int duration = 3,
}) {
  toastification.show(
    context: context,
    title: CustomText(
      text: message,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      maxLines: 3,
    ),
    type: notificationType,
    style: ToastificationStyle.flat,
    alignment: Alignment.topCenter,
    direction: TextDirection.rtl,
    autoCloseDuration: Duration(seconds: duration),
    showIcon: false,
    borderRadius: BorderRadius.circular(12),
    backgroundColor: AppColors.grey7,
    foregroundColor: AppColors.primary,
    borderSide: BorderSide(width: 0, color: AppColors.transparent),
  );
}
