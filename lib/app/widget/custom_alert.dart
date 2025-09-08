import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import 'custom_text.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert({
    super.key,
    required this.title,
    required this.body,
    required this.submitWidget,
  });

  final String title, body;
  final Widget submitWidget;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(
        text: title,
        color: AppColors.black,
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
      content: CustomText(
        text: body,
        color: AppColors.black,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        maxLines: 5,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: const CustomText(
              text: "cancel",
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 10),
        submitWidget,
      ],
    );
  }
}

// CustomAlert(
// title: "Delete User",
// body: "Are you sure you want to delete",
// submitWidget: const SizedBox(),
// );
