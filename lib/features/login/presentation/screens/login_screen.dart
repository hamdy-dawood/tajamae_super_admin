import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tajamae_super_admin/app/dependancy_injection/dependancy_injection.dart';
import 'package:tajamae_super_admin/app/helper/extension.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/utils/image_manager.dart';
import 'package:tajamae_super_admin/app/widget/custom_button.dart';
import 'package:tajamae_super_admin/app/widget/custom_constrained_scaffold.dart';
import 'package:tajamae_super_admin/app/widget/custom_text.dart';
import 'package:tajamae_super_admin/app/widget/custom_text_form_field.dart';
import 'package:tajamae_super_admin/app/widget/emit_loading_item.dart';
import 'package:tajamae_super_admin/app/widget/toastification_widget.dart';
import 'package:tajamae_super_admin/features/home/presentaion/screens/home_screen.dart';

import '../cubit/login_cubit.dart';
import '../cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LogInCubit>(),
      child: const LoginBody(),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LogInCubit>();

    return CustomConstrainedScaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Form(
          key: cubit.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0.1.sh),
                Center(child: Image.asset(ImageManager.homeLogo, height: 80)),
                const SizedBox(height: 50),
                const CustomText(
                  text: "تسجيل الدخول",
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
                const SizedBox(height: 45),
                CustomTextFormField(
                  title: "اسم المستخدم",
                  icon: ImageManager.person,
                  controller: cubit.userNameController,
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
                      controller: cubit.passwordController,
                      filledColor: AppColors.white,
                      titleColor: AppColors.black,
                      titleFontSize: 16,
                      maxLines: 1,
                      suffixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: InkWell(
                          onTap: () {
                            cubit.changeVisibility();
                          },
                          child: Container(
                            width: 50,
                            margin: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.grey2,
                            ),
                            child: Center(
                              child: CustomText(
                                text: cubit.isObscure ? "اظهار" : "اخفاء",
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      obscureText: cubit.isObscure,
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
                const SizedBox(height: 10),
                // GestureDetector(
                //   onTap: () {
                //   },
                //   child: const CustomText(
                //     text: "نسيت كلمة المرور؟",
                //     color: AppColors.black,
                //     fontWeight: FontWeight.w400,
                //     fontSize: 14,
                //   ),
                // ),
                const SizedBox(height: 40),
                BlocConsumer<LogInCubit, LogInStates>(
                  listener: (context, state) {
                    if (state is LogInSuccessState) {
                      MagicRouter.navigateTo(
                        page: HomeScreen(),
                        withHistory: false,
                      );
                    } else if (state is LogInFailState) {
                      showToastificationWidget(
                        message: "خطأ في البيانات",
                        context: context,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LogInLoadingState) {
                      return const EmitLoadingItem();
                    }
                    return CustomButton(
                      height: 55,
                      color: AppColors.primary,
                      text: "تسجيل",
                      fontColor: AppColors.white,
                      fontSize: 16,
                      onTap: () {
                        cubit.login();
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
