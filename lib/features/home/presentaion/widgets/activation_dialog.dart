import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajamae_super_admin/app/helper/extension.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/widget/custom_text.dart';
import 'package:tajamae_super_admin/app/widget/overlay_loading.dart';
import 'package:tajamae_super_admin/app/widget/toastification_widget.dart';
import 'package:tajamae_super_admin/features/home/domain/entities/user_entity.dart';
import 'package:tajamae_super_admin/features/home/presentaion/cubit/home_cubit.dart';
import 'package:toastification/toastification.dart';

class ActivationAccountsDialog extends StatelessWidget {
  const ActivationAccountsDialog({
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
      content: CustomText(
        text: userEntity.active
            ? 'هل انت متأكد من ايقاف ${userEntity.displayName}؟'
            : 'هل انت متأكد من تفعيل ${userEntity.displayName}؟',
        color: AppColors.black,
        fontWeight: FontWeight.w600,
        textAlign: TextAlign.center,
        fontSize: 16,
        maxLines: 5,
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
            if (state is ActivationAccountFailState) {
              OverlayLoadingProgress.stop();
              if (wantPop) MagicRouter.pop();
              MagicRouter.pop();
              showToastificationWidget(
                message: state.message,
                context: context,
              );
            } else if (state is ActivationAccountSuccessState) {
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
            } else if (state is ActivationAccountLoadingState) {
              OverlayLoadingProgress.start(context);
            }
          },
          builder: (context, state) {
            return CupertinoDialogAction(
              onPressed: () {
                cubit.activationAccount(
                  id: userEntity.id,
                  active: '${!userEntity.active}',
                );
              },
              child: CustomText(
                text: 'حفظ',
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
