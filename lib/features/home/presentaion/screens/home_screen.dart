import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajamae_super_admin/app/dependancy_injection/dependancy_injection.dart';
import 'package:tajamae_super_admin/app/helper/extension.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/utils/image_manager.dart';
import 'package:tajamae_super_admin/app/widget/custom_text.dart';
import 'package:tajamae_super_admin/app/widget/emit_failed_item.dart';
import 'package:tajamae_super_admin/app/widget/emit_loading_item.dart';
import 'package:tajamae_super_admin/app/widget/list_view_pagination.dart';
import 'package:tajamae_super_admin/app/widget/svg_icons.dart';
import 'package:tajamae_super_admin/features/home/presentaion/cubit/home_cubit.dart';
import 'package:tajamae_super_admin/features/home/presentaion/widgets/admin_container.dart';
import 'package:tajamae_super_admin/features/login/presentation/screens/super_create_admin.dart';

import '../widgets/config_dialog.dart';
import '../widgets/logout_dialog.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getUsers(),
      child: HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        centerTitle: true,
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Image.asset(ImageManager.homeLogo, height: 45),
        ),
        actions: [
          IconButton(
            onPressed: () {
              MagicRouter.navigateTo(page: NotificationsScreen(cubit: cubit));
            },
            icon: SvgIcon(
              icon: ImageManager.notifications,
              color: AppColors.primary,
              height: 25,
            ),
          ),
          IconButton(
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder:
                    (_) => BlocProvider.value(
                      value: cubit,
                      child: ConfigDialog(cubit: cubit),
                    ),
              );
            },
            icon: SvgIcon(
              icon: ImageManager.settings,
              color: AppColors.primary,
              height: 25,
            ),
          ),
          IconButton(
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder:
                    (_) => BlocProvider.value(
                      value: cubit,
                      child: LogoutDialog(cubit: cubit),
                    ),
              );
            },
            icon: SvgIcon(
              icon: ImageManager.logout,
              color: AppColors.primary,
              height: 25,
            ),
          ),
          SizedBox(width: 5),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                color: AppColors.white,
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(15),
                    //   child: CustomTextFormField(
                    //     hintText: '\t \t بحث',
                    //     hintFontSize: 16,
                    //     suffixIcon: Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 12),
                    //       child: SvgIcon(
                    //         icon: ImageManager.search,
                    //         color: AppColors.grey,
                    //         height: 30,
                    //       ),
                    //     ),
                    //     controller: cubit.searchController,
                    //     onFieldSubmitted: (value) {
                    //       cubit.clearUsersData();
                    //       cubit.getUsers();
                    //     },
                    //     filledColor: AppColors.backgroundColor,
                    //     titleColor: AppColors.black,
                    //     borderColor: AppColors.transparent,
                    //     titleFontSize: 16,
                    //     borderRadius: 14,
                    //     isLastInput: true,
                    //   ),
                    // ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  MagicRouter.navigateTo(page: SuperCreateAdminScreen());
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgIcon(
                        icon: ImageManager.add,
                        color: AppColors.white,
                        height: 24,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: "اضافة ادمن",
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is GetUsersLoadingState) {
                      return const EmitLoadingItem(size: 60);
                    } else if (state is GetUsersFailState) {
                      return EmitFailedItem(
                        text: state.message,
                        wantReload: true,
                        onTap: () {
                          cubit.getUsers();
                        },
                      );
                    } else if (cubit.users.isEmpty) {
                      return SizedBox();
                    }
                    return ListViewPagination(
                      onRefresh: () async {
                        await Future.delayed(Duration(seconds: 1));
                        cubit.clearUsersData();
                        cubit.getUsers();
                      },
                      addEvent: () {
                        cubit.getUsers();
                      },
                      itemCount:
                          cubit.hasReachedMax
                              ? cubit.users.length
                              : cubit.users.length + 1,
                      itemBuilder: (context, index) {
                        if (index == cubit.users.length) {
                          return const EmitLoadingItem(size: 20);
                        }
                        return AdminContainer(
                          userEntity: cubit.users[index],
                          homeCubit: cubit,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
