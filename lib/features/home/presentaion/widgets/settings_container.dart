import 'package:flutter/material.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/widget/custom_text.dart';
import 'package:tajamae_super_admin/app/widget/svg_icons.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title, icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SvgIcon(icon: icon, color: AppColors.primary, height: 25),
              SizedBox(width: 15),
              Expanded(
                child: CustomText(
                  text: title,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  maxLines: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
