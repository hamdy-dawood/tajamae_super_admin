// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tajamae_super_admin/app/utils/colors.dart';
// import 'package:tajamae_super_admin/app/utils/constance.dart';
// import 'package:tajamae_super_admin/app/utils/image_manager.dart';
// import 'package:tajamae_super_admin/app/widget/custom_button.dart';
// import 'package:tajamae_super_admin/app/widget/custom_text.dart';
// import 'package:tajamae_super_admin/app/widget/svg_icons.dart';
//
// import '../../domain/entities/user_entity.dart';
// import '../cubit/home_cubit.dart';
// import '../widgets/activation_dialog.dart';
// import '../widgets/edit_expire_date_dialog.dart';
// import '../widgets/reset_password_dialog.dart';
//
// class DetailsScreen extends StatelessWidget {
//   const DetailsScreen({
//     super.key,
//     required this.userDataEntity,
//     required this.homeCubit,
//   });
//
//   final UserDataEntity userDataEntity;
//   final HomeCubit homeCubit;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         surfaceTintColor: AppColors.white,
//         centerTitle: true,
//         title: CustomText(
//           text: "تفاصيل الحساب",
//           color: AppColors.black,
//           fontWeight: FontWeight.w600,
//           fontSize: 18,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: AppColors.grey5),
//                 ),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 25,
//                       backgroundColor: AppColors.grey2,
//                       child: SvgIcon(
//                         icon: ImageManager.company,
//                         color: AppColors.primary,
//                         height: 22,
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CustomText(
//                             text: userDataEntity.displayName,
//                             color: AppColors.black,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 20,
//                             maxLines: 5,
//                           ),
//                           CustomText(
//                             text: userDataEntity.username,
//                             color: AppColors.black,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16,
//                             maxLines: 5,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: AppColors.grey5),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       text: "معلومات الحساب",
//                       color: AppColors.primary,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 18,
//                       maxLines: 5,
//                     ),
//                     SizedBox(height: 5),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           _RowItem(
//                             title: "الحالة",
//                             value: userDataEntity.active ? 'نشطة' : 'غير نشطة',
//                             icon: Icons.info_outline,
//                             color:
//                                 userDataEntity.active
//                                     ? AppColors.green2
//                                     : AppColors.red,
//                           ),
//                           Divider(),
//                           _RowItem(
//                             title: "الهاتف",
//                             value: userDataEntity.phone,
//                             icon: Icons.phone_outlined,
//                           ),
//                           Divider(),
//                           _RowItem(
//                             title: "تاريخ الانتهاء",
//                             value:
//                                 "${AppConstance.dateFormat.format(userDataEntity.expireDate)}",
//                             icon: Icons.date_range_outlined,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 40),
//               CustomButton(
//                 height: 55,
//                 color: AppColors.white,
//                 fontColor: AppColors.black,
//                 fontSize: 16,
//                 borderRadius: 30,
//                 isBorderButton: true,
//                 borderColor:
//                     userDataEntity.active ? AppColors.color1 : AppColors.green2,
//                 onTap: () {
//                   showCupertinoDialog(
//                     context: context,
//                     builder:
//                         (_) => BlocProvider.value(
//                           value: homeCubit,
//                           child: ActivationAccountsDialog(
//                             cubit: homeCubit,
//                             userEntity: userDataEntity,
//                             wantPop: true,
//                           ),
//                         ),
//                   );
//                 },
//                 widget: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CustomText(
//                       text:
//                           userDataEntity.active
//                               ? "ايقاف الحساب"
//                               : "تفعيل الحساب",
//                       color:
//                           userDataEntity.active
//                               ? AppColors.color1
//                               : AppColors.green2,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                       maxLines: 5,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 15),
//               CustomButton(
//                 height: 55,
//                 color: AppColors.white,
//                 fontColor: AppColors.black,
//                 fontSize: 16,
//                 borderRadius: 30,
//                 isBorderButton: true,
//                 borderColor: AppColors.grey4,
//                 onTap: () {
//                   showCupertinoDialog(
//                     context: context,
//                     builder:
//                         (_) => BlocProvider.value(
//                           value: homeCubit,
//                           child: EditExpireDateDialog(
//                             cubit: homeCubit,
//                             userEntity: userDataEntity,
//                             wantPop: true,
//                           ),
//                         ),
//                   );
//                 },
//                 widget: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.edit_calendar, color: AppColors.grey, size: 25),
//                     SizedBox(width: 10),
//                     CustomText(
//                       text: "تعديل تاريخ الانتهاء",
//                       color: AppColors.black,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                       maxLines: 5,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 15),
//               CustomButton(
//                 height: 55,
//                 color: AppColors.color1,
//                 fontColor: AppColors.white,
//                 fontSize: 16,
//                 borderRadius: 30,
//                 onTap: () {
//                   showCupertinoDialog(
//                     context: context,
//                     builder:
//                         (_) => BlocProvider.value(
//                           value: homeCubit,
//                           child: ResetPasswordDialog(
//                             cubit: homeCubit,
//                             userEntity: userDataEntity,
//                             wantPop: true,
//                           ),
//                         ),
//                   );
//                 },
//                 widget: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.lock_open, color: AppColors.white, size: 25),
//                     SizedBox(width: 10),
//                     CustomText(
//                       text: "اعادة تعيين كلمة المرور",
//                       color: AppColors.white,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                       maxLines: 5,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 15),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _RowItem extends StatelessWidget {
//   const _RowItem({
//     required this.title,
//     required this.value,
//     required this.icon,
//     this.color,
//   });
//
//   final String title, value;
//   final IconData icon;
//   final Color? color;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(icon, color: AppColors.grey, size: 25),
//                 SizedBox(width: 10),
//                 Flexible(
//                   child: CustomText(
//                     text: title,
//                     color: AppColors.black,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 16,
//                     maxLines: 5,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: 10),
//           Expanded(
//             child: Localizations.override(
//               context: context,
//               locale: Locale("en"),
//               child: CustomText(
//                 text: value,
//                 color: color ?? AppColors.black,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 18,
//                 maxLines: 5,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
