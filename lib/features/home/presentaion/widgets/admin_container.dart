import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';
import 'package:tajamae_super_admin/app/helper/extension.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/utils/constance.dart';
import 'package:tajamae_super_admin/app/utils/image_manager.dart';
import 'package:tajamae_super_admin/app/widget/custom_text.dart';
import 'package:tajamae_super_admin/app/widget/svg_icons.dart';
import 'package:tajamae_super_admin/features/home/domain/entities/user_entity.dart';
import 'package:tajamae_super_admin/features/home/presentaion/cubit/home_cubit.dart';
import 'package:tajamae_super_admin/features/home/presentaion/widgets/activation_dialog.dart';
import 'package:tajamae_super_admin/features/home/presentaion/widgets/edit_expire_date_dialog.dart';
import 'package:tajamae_super_admin/features/home/presentaion/widgets/reset_password_dialog.dart';

import '../screens/events_screen.dart';

class AdminContainer extends StatelessWidget {
  const AdminContainer({
    super.key,
    required this.userEntity,
    required this.homeCubit,
  });

  final UserDataEntity userEntity;
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          MagicRouter.navigateTo(
            page: EventsScreen(owner: userEntity.id, cubit: homeCubit),
          );
        },
        child: Container(
          padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
          decoration: BoxDecoration(
            color: userEntity.deleted
                ? AppColors.red.withOpacity(0.5)
                : AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 8,
                backgroundColor:
                    userEntity.active ? AppColors.green : AppColors.red,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [SizedBox(width: 10)]),
                    SizedBox(height: 10),
                    CustomText(
                      text: userEntity.displayName,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      maxLines: 2,
                    ),
                    SizedBox(height: 2),
                    CustomText(
                      text: "@${userEntity.userName}",
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      maxLines: 2,
                    ),
                    SizedBox(height: 5),
                    CustomText(
                      text: AppConstance().getDateDifferenceFormatted(
                          DateTime.now(), userEntity.expireDate),
                      color: AppColors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              OptionsWidget(userEntity: userEntity, homeCubit: homeCubit),
            ],
          ),
        ),
      ),
    );
  }
}

class _RowDotsOptions extends StatelessWidget {
  const _RowDotsOptions({required this.onTap, required this.text});

  final Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 15, bottom: 10, top: 5),
        child: CustomText(
          text: text,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          textAlign: TextAlign.start,
          color: AppColors.black,
        ),
      ),
    );
  }
}

class OptionsWidget extends StatelessWidget {
  const OptionsWidget({
    super.key,
    required this.userEntity,
    required this.homeCubit,
  });

  final UserDataEntity userEntity;
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showPopover(
          barrierColor: AppColors.transparent,
          context: context,
          bodyBuilder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _RowDotsOptions(
                    onTap: () {
                      MagicRouter.pop();
                      showCupertinoDialog(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: homeCubit,
                          child: ActivationAccountsDialog(
                            cubit: homeCubit,
                            userEntity: userEntity,
                          ),
                        ),
                      );
                    },
                    text: userEntity.active ? 'ايقاف ' : 'تفعيل',
                  ),
                  Divider(thickness: .4),
                  _RowDotsOptions(
                    onTap: () {
                      MagicRouter.pop();
                      showCupertinoDialog(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: homeCubit,
                          child: EditExpireDateDialog(
                            cubit: homeCubit,
                            userEntity: userEntity,
                          ),
                        ),
                      );
                    },
                    text: "تعديل تاريخ الانتهاء",
                  ),
                  Divider(thickness: .4),
                  _RowDotsOptions(
                    onTap: () {
                      MagicRouter.pop();
                      showCupertinoDialog(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: homeCubit,
                          child: ResetPasswordDialog(
                            cubit: homeCubit,
                            userEntity: userEntity,
                          ),
                        ),
                      );
                    },
                    text: "اعادة تعيين كلمة المرور",
                  ),
                ],
              ),
            );
          },
          direction: PopoverDirection.bottom,
          backgroundColor: Colors.white,
          width: 180,
          height: 180,
          arrowHeight: 10,
          arrowWidth: 20,
        );
      },
      icon: SvgIcon(
        icon: ImageManager.verticalDots,
        color: AppColors.grey,
        height: 25,
      ),
    );
  }
}
