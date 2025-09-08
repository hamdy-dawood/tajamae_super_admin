import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajamae_super_admin/app/dependancy_injection/dependancy_injection.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/utils/image_manager.dart';
import 'package:tajamae_super_admin/app/widget/emit_failed_item.dart';
import 'package:tajamae_super_admin/app/widget/emit_loading_item.dart';
import 'package:tajamae_super_admin/app/widget/list_view_pagination.dart';
import 'package:tajamae_super_admin/app/widget/svg_icons.dart';
import 'package:tajamae_super_admin/features/home/presentaion/cubit/home_cubit.dart';
import 'package:tajamae_super_admin/features/home/presentaion/widgets/admin_container.dart';

import '../widgets/logout_dialog.dart';

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
        title: Image.asset(ImageManager.homeLogo, height: 45),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder:
                      (_) => BlocProvider.value(
                        value: cubit,
                        child: LogoutDialog(cubit: cubit),
                      ),
                );
              },
              child: SvgIcon(
                icon: ImageManager.logout,
                color: AppColors.primary,
                height: 25,
              ),
            ),
          ),
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
