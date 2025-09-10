import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/utils/image_manager.dart';
import 'package:tajamae_super_admin/app/widget/custom_text.dart';
import 'package:tajamae_super_admin/features/home/presentaion/cubit/home_cubit.dart';

import '../widgets/config_dialog.dart';
import '../widgets/settings_container.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.cubit});

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: cubit, child: SettingsBody(cubit: cubit));
  }
}

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key, required this.cubit});

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        centerTitle: true,
        title: CustomText(
          text: "الاعدادات",
          color: AppColors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          SettingsContainer(
            title: "صلاحية الماسح الضوئي",
            icon: ImageManager.scanner,
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder:
                    (_) => BlocProvider.value(
                      value: cubit,
                      child: ConfigDialog(cubit: cubit),
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}
