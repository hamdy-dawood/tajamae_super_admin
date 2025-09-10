import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tajamae_super_admin/app/dependancy_injection/dependancy_injection.dart';
import 'package:tajamae_super_admin/app/helper/extension.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/utils/image_manager.dart';
import 'package:tajamae_super_admin/app/widget/custom_button.dart';
import 'package:tajamae_super_admin/app/widget/custom_text.dart';
import 'package:tajamae_super_admin/app/widget/custom_text_form_field.dart';
import 'package:tajamae_super_admin/app/widget/emit_loading_item.dart';
import 'package:tajamae_super_admin/app/widget/toastification_widget.dart';
import 'package:tajamae_super_admin/features/home/presentaion/screens/home_screen.dart';
import 'package:toastification/toastification.dart';

import '../cubit/login_cubit.dart';
import '../cubit/login_states.dart';

class SuperCreateAdminScreen extends StatelessWidget {
  const SuperCreateAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LogInCubit>(),
      child: const SuperCreateAdminBody(),
    );
  }
}

class SuperCreateAdminBody extends StatelessWidget {
  const SuperCreateAdminBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LogInCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: cubit.adminFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0.05.sh),
                const CustomText(
                  text: "اضافة ادمن جديد",
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
                const SizedBox(height: 45),
                CustomTextFormField(
                  title: "الإسم الكامل",
                  icon: ImageManager.person,
                  controller: cubit.adminFullNameController,
                  filledColor: AppColors.white,
                  titleColor: AppColors.black,
                  titleFontSize: 16,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "من فضلك ادخل الإسم الكامل !";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  title: "اسم المستخدم",
                  icon: ImageManager.person,
                  controller: cubit.adminUserNameController,
                  filledColor: AppColors.white,
                  titleColor: AppColors.black,
                  titleFontSize: 16,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "من فضلك ادخل اسم المستخدم !";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<LogInCubit, LogInStates>(
                  builder: (context, state) {
                    return CustomTextFormField(
                      title: "كلمة المرور",
                      icon: ImageManager.lock,
                      controller: cubit.adminPasswordController,
                      filledColor: AppColors.white,
                      titleColor: AppColors.black,
                      titleFontSize: 16,
                      maxLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "من فضلك ادخل كلمة المرور !";
                        }
                        return null;
                      },
                      isLastInput: true,
                    );
                  },
                ),
                const SizedBox(height: 40),
                BlocConsumer<LogInCubit, LogInStates>(
                  listener: (context, state) {
                    if (state is AddAdminSuccessState) {
                      MagicRouter.navigateTo(
                        page: HomeScreen(),
                        withHistory: false,
                      );
                      showToastificationWidget(
                        message: "تمت الاضافة بنجاح",
                        context: context,
                        notificationType: ToastificationType.success,
                      );
                    } else if (state is AddAdminFailState) {
                      showToastificationWidget(
                        message: "خطأ في البيانات",
                        context: context,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AddAdminLoadingState) {
                      return const EmitLoadingItem();
                    }
                    return CustomButton(
                      height: 55,
                      color: AppColors.primary,
                      text: "اضافة",
                      fontColor: AppColors.white,
                      fontSize: 16,
                      onTap: () {
                        cubit.addAmin();
                      },
                    );
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
