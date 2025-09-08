import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajamae_super_admin/app/helper/extension.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/widget/custom_text.dart';
import 'package:tajamae_super_admin/app/widget/custom_text_form_field.dart';
import 'package:tajamae_super_admin/app/widget/overlay_loading.dart';
import 'package:tajamae_super_admin/app/widget/toastification_widget.dart';
import 'package:tajamae_super_admin/features/home/domain/entities/user_entity.dart';
import 'package:tajamae_super_admin/features/home/presentaion/cubit/home_cubit.dart';
import 'package:toastification/toastification.dart';

class ResetPasswordDialog extends StatelessWidget {
  const ResetPasswordDialog({
    super.key,
    required this.cubit,
    required this.userEntity,
    this.wantPop = false,
  });

  final HomeCubit cubit;
  final UserDataEntity userEntity;
  final bool wantPop;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: CustomText(
        text: 'اعادة تعيين كلمة المرور',
        color: AppColors.black,
        fontWeight: FontWeight.w600,
        textAlign: TextAlign.center,
        fontSize: 16,
        maxLines: 5,
      ),
      content: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Form(
            key: cubit.resetPasswordFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: userEntity.displayName,
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  fontSize: 16,
                  maxLines: 5,
                ),
                SizedBox(height: 15),
                CustomTextFormField(
                  borderColor: AppColors.grey10,
                  hintText: 'كلمة المرور',
                  controller: cubit.passwordController,
                  filledColor: AppColors.white,
                  isLastInput: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "هذا الحقل مطلوب !";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: CustomText(
            text: 'لا',
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
            fontSize: 16,
          ),
        ),
        BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is ResetPasswordFailState) {
              OverlayLoadingProgress.stop();
              if (wantPop) MagicRouter.pop();
              MagicRouter.pop();
              showToastificationWidget(
                message: state.message,
                context: context,
              );
            } else if (state is ResetPasswordSuccessState) {
              OverlayLoadingProgress.stop();
              if (wantPop) MagicRouter.pop();
              MagicRouter.pop();
              cubit.clearUsersData();
              cubit.getUsers();
              showToastificationWidget(
                message: 'تم الحفظ بنجاح',
                context: context,
                notificationType: ToastificationType.success,
              );
            } else if (state is ResetPasswordLoadingState) {
              OverlayLoadingProgress.start(context);
            }
          },
          builder: (context, state) {
            return CupertinoDialogAction(
              onPressed: () {
                cubit.resetPassword(id: userEntity.id);
              },
              child: CustomText(
                text: 'تعديل',
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
                fontSize: 16,
              ),
            );
          },
        ),
      ],
    );
  }
}
