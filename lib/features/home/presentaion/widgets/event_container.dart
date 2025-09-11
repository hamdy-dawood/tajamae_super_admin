import 'package:flutter/material.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/widget/custom_text.dart';
import 'package:tajamae_super_admin/features/home/presentaion/cubit/home_cubit.dart';

import '../../domain/entities/events_entity.dart';

class EventContainer extends StatelessWidget {
  const EventContainer({
    super.key,
    required this.eventsEntity,
    required this.homeCubit,
  });

  final EventsEntity eventsEntity;
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Container(
        padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 8,
              backgroundColor:
                  eventsEntity.active ? AppColors.green : AppColors.red,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  CustomText(
                    text: eventsEntity.title,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    maxLines: 2,
                  ),
                  SizedBox(height: 5),
                  CustomText(
                    text: eventsEntity.address,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
