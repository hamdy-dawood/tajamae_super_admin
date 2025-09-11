import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajamae_super_admin/app/helper/extension.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/widget/custom_text.dart';
import 'package:tajamae_super_admin/app/widget/custom_text_form_field.dart';
import 'package:tajamae_super_admin/app/widget/emit_failed_item.dart';
import 'package:tajamae_super_admin/app/widget/emit_loading_item.dart';
import 'package:tajamae_super_admin/app/widget/overlay_loading.dart';
import 'package:tajamae_super_admin/app/widget/toastification_widget.dart';
import 'package:tajamae_super_admin/features/home/presentaion/cubit/home_cubit.dart';
import 'package:toastification/toastification.dart';

class ConfigDialog extends StatefulWidget {
  const ConfigDialog({super.key, required this.cubit});

  final HomeCubit cubit;

  @override
  State<ConfigDialog> createState() => _ConfigDialogState();
}

class _ConfigDialogState extends State<ConfigDialog> {
  @override
  void initState() {
    widget.cubit.getConfig();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: CustomText(
        text: "صلاحية الماسح الضوئي",
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is GetConfigLoadingState) {
                    return const EmitLoadingItem();
                  } else if (state is GetConfigFailState) {
                    return EmitFailedItem(text: state.message);
                  }
                  return CustomTextFormField(
                    borderColor: AppColors.grey10,
                    hintText: 'صلاحية الماسح الضوئي',
                    controller: widget.cubit.barcodeLicenseController,
                    filledColor: AppColors.white,
                    isLastInput: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "هذا الحقل مطلوب !";
                      }
                      return null;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is GetConfigLoadingState) {
              return const SizedBox();
            }
            return CupertinoDialogAction(
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
            );
          },
        ),
        BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is EditConfigFailState) {
              OverlayLoadingProgress.stop();
              MagicRouter.pop();
              showToastificationWidget(
                message: state.message,
                context: context,
              );
            } else if (state is EditConfigSuccessState) {
              OverlayLoadingProgress.stop();
              MagicRouter.pop();
              showToastificationWidget(
                message: 'تم الحفظ بنجاح',
                context: context,
                notificationType: ToastificationType.success,
              );
            } else if (state is EditConfigLoadingState) {
              OverlayLoadingProgress.start(context);
            }
          },
          builder: (context, state) {
            if (state is GetConfigLoadingState || state is GetConfigFailState) {
              return const SizedBox();
            }
            return CupertinoDialogAction(
              onPressed: () {
                if (widget.cubit.barcodeLicenseController.text.isNotEmpty) {
                  widget.cubit.editConfig();
                }
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
