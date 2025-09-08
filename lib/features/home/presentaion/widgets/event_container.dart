import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/utils/image_manager.dart';
import 'package:tajamae_super_admin/app/widget/custom_text.dart';
import 'package:tajamae_super_admin/app/widget/svg_icons.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
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
                  SizedBox(height: 10),
                  CustomText(
                    text: eventsEntity.title,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    maxLines: 10,
                  ),
                  SizedBox(height: 5),
                  CustomText(
                    text: eventsEntity.address,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: eventsEntity.active ? AppColors.green : AppColors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              child: CustomText(
                text: eventsEntity.active ? 'نشطة' : 'غير نشطة',
                color: AppColors.white,
              ),
            ),
            SizedBox(width: 10),

            // OptionsWidget(userEntity: userEntity, homeCubit: homeCubit),
          ],
        ),
      ),
    );
  }
}

// class _RowDotsOptions extends StatelessWidget {
//   const _RowDotsOptions({required this.onTap, required this.text});
//
//   final Function() onTap;
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.only(right: 15, bottom: 10, top: 5),
//         child: CustomText(
//           text: text,
//           fontWeight: FontWeight.w400,
//           fontSize: 16,
//           textAlign: TextAlign.start,
//           color: AppColors.black,
//         ),
//       ),
//     );
//   }
// }
//
// class OptionsWidget extends StatelessWidget {
//   const OptionsWidget({
//     super.key,
//     required this.userEntity,
//     required this.homeCubit,
//   });
//
//   final UserDataEntity userEntity;
//   final HomeCubit homeCubit;
//
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         showPopover(
//           barrierColor: AppColors.transparent,
//           context: context,
//           bodyBuilder: (context) {
//             return Padding(
//               padding: const EdgeInsets.only(top: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _RowDotsOptions(
//                     onTap: () {
//                       MagicRouter.pop();
//                       showCupertinoDialog(
//                         context: context,
//                         builder:
//                             (_) => BlocProvider.value(
//                               value: homeCubit,
//                               child: ActivationAccountsDialog(
//                                 cubit: homeCubit,
//                                 userEntity: userEntity,
//                               ),
//                             ),
//                       );
//                     },
//                     text: userEntity.active ? 'ايقاف ' : 'تفعيل',
//                   ),
//                   Divider(thickness: .4),
//                   _RowDotsOptions(
//                     onTap: () {
//                       MagicRouter.pop();
//                       showCupertinoDialog(
//                         context: context,
//                         builder:
//                             (_) => BlocProvider.value(
//                               value: homeCubit,
//                               child: EditExpireDateDialog(
//                                 cubit: homeCubit,
//                                 userEntity: userEntity,
//                               ),
//                             ),
//                       );
//                     },
//                     text: "تعديل تاريخ الانتهاء",
//                   ),
//                   Divider(thickness: .4),
//                   _RowDotsOptions(
//                     onTap: () {
//                       MagicRouter.pop();
//                       showCupertinoDialog(
//                         context: context,
//                         builder:
//                             (_) => BlocProvider.value(
//                               value: homeCubit,
//                               child: ResetPasswordDialog(
//                                 cubit: homeCubit,
//                                 userEntity: userEntity,
//                               ),
//                             ),
//                       );
//                     },
//                     text: "اعادة تعيين كلمة المرور",
//                   ),
//                 ],
//               ),
//             );
//           },
//           direction: PopoverDirection.bottom,
//           backgroundColor: Colors.white,
//           width: 180,
//           height: 180,
//           arrowHeight: 10,
//           arrowWidth: 20,
//         );
//       },
//       icon: SvgIcon(
//         icon: ImageManager.verticalDots,
//         color: AppColors.grey,
//         height: 25,
//       ),
//     );
//   }
// }
