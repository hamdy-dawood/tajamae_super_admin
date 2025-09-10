import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/widget/custom_text.dart';
import 'package:tajamae_super_admin/app/widget/emit_failed_item.dart';
import 'package:tajamae_super_admin/app/widget/emit_loading_item.dart';
import 'package:tajamae_super_admin/app/widget/list_view_pagination.dart';
import 'package:tajamae_super_admin/features/home/presentaion/cubit/home_cubit.dart';

import '../widgets/notification_container.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key, required this.cubit});

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: cubit, child: HomeBody(cubit: cubit));
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key, required this.cubit});

  final HomeCubit cubit;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    widget.cubit.clearNotificationsData();
    widget.cubit.getNotifications();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeBodyData(cubit: widget.cubit);
  }
}

class HomeBodyData extends StatelessWidget {
  const HomeBodyData({super.key, required this.cubit});

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        centerTitle: true,
        title: CustomText(
          text: "الإشعارات",
          color: AppColors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is GetNotificationsLoadingState) {
                      return const EmitLoadingItem(size: 60);
                    } else if (state is GetNotificationsFailState) {
                      return EmitFailedItem(
                        text: state.message,
                        wantReload: true,
                        onTap: () {
                          cubit.getNotifications();
                        },
                      );
                    } else if (cubit.notifications.isEmpty) {
                      return SizedBox();
                    }
                    return ListViewPagination(
                      onRefresh: () async {
                        await Future.delayed(Duration(seconds: 1));
                        cubit.clearNotificationsData();
                        cubit.getNotifications();
                      },
                      addEvent: () {
                        cubit.getNotifications();
                      },
                      itemCount:
                          cubit.notificationHasReachedMax
                              ? cubit.notifications.length
                              : cubit.notifications.length + 1,
                      itemBuilder: (context, index) {
                        if (index == cubit.notifications.length) {
                          return const EmitLoadingItem(size: 20);
                        }
                        return NotificationContainer(
                          notificationsEntity: cubit.notifications[index],
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


