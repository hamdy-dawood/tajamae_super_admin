import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'custom_text.dart';

class EmitFailedItem extends StatelessWidget {
  const EmitFailedItem({
    super.key,
    required this.text,
    this.wantReload = false,
    this.onTap,
  });

  final String text;
  final bool wantReload;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            text: text,
            color: AppColors.red,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          if (wantReload) const SizedBox(height: 20),
          if (wantReload)
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: CustomText(
                text: "حاول مرة أخرى",
                color: AppColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}
