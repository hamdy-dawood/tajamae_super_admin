import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/widget/custom_text.dart';

import '../../domain/entities/notifications_entity.dart';

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({super.key, required this.notificationsEntity});

  final NotificationsEntity notificationsEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Opacity(
        opacity: notificationsEntity.isSeen ? 0.4 : 1,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: notificationsEntity.title,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      maxLines: 10,
                    ),
                    SizedBox(height: 5),
                    CustomText(
                      text: notificationsEntity.body,
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      maxLines: 3,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
