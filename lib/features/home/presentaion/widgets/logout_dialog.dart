import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajamae_super_admin/app/caching/shared_prefs.dart';
import 'package:tajamae_super_admin/app/helper/extension.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/widget/custom_text.dart';
import 'package:tajamae_super_admin/app/widget/overlay_loading.dart';
import 'package:tajamae_super_admin/app/widget/toastification_widget.dart';
import 'package:tajamae_super_admin/features/login/presentation/screens/login_screen.dart';

import '../cubit/home_cubit.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key, required this.cubit});

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: CustomText(
        text: 'تأكيد العملية',
        color: AppColors.black,
        fontWeight: FontWeight.w700,
        textAlign: TextAlign.center,
        fontSize: 16,
      ),
      content: CustomText(
        text: 'هل انت متأكد من تأكيد العمليه؟',
        color: AppColors.black,
        fontWeight: FontWeight.w300,
        textAlign: TextAlign.center,
        fontSize: 16,
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () {
            cubit.logout();
          },
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is LogOutSuccessState) {
                OverlayLoadingProgress.stop();
                Caching.clearAllData();
                MagicRouter.navigateTo(page: LoginScreen(), withHistory: false);
              } else if (state is LogOutFailState) {
                OverlayLoadingProgress.stop();
                showToastificationWidget(
                  message: state.message,
                  context: context,
                );
              } else if (state is LogOutLoadingState) {
                OverlayLoadingProgress.start(context);
              }
            },
            builder: (context, state) {
              return CustomText(
                text: 'نعم',
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                fontSize: 16,
              );
            },
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: CustomText(
            text: 'لا',
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
