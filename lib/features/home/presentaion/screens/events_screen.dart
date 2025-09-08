import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/widget/custom_text.dart';
import 'package:tajamae_super_admin/app/widget/emit_failed_item.dart';
import 'package:tajamae_super_admin/app/widget/emit_loading_item.dart';
import 'package:tajamae_super_admin/app/widget/list_view_pagination.dart';
import 'package:tajamae_super_admin/features/home/presentaion/cubit/home_cubit.dart';

import '../widgets/event_container.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key, required this.cubit, required this.owner});

  final HomeCubit cubit;
  final String owner;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: HomeBody(cubit: cubit, owner: owner),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key, required this.cubit, required this.owner});

  final HomeCubit cubit;
  final String owner;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    widget.cubit.clearEventsData();
    widget.cubit.getEvents(owner: widget.owner);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeBodyData(owner: widget.owner, cubit: widget.cubit);
  }
}

class HomeBodyData extends StatelessWidget {
  const HomeBodyData({super.key, required this.cubit, required this.owner});

  final String owner;

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
          text: 'Events',
          color: AppColors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
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
                    if (state is GetEventsLoadingState) {
                      return const EmitLoadingItem(size: 60);
                    } else if (state is GetEventsFailState) {
                      return EmitFailedItem(
                        text: state.message,
                        wantReload: true,
                        onTap: () {
                          cubit.getEvents(owner: owner);
                        },
                      );
                    } else if (cubit.events.isEmpty) {
                      return SizedBox();
                    }
                    return ListViewPagination(
                      onRefresh: () async {
                        await Future.delayed(Duration(seconds: 1));
                        cubit.clearEventsData();
                        cubit.getEvents(owner: owner);
                      },
                      addEvent: () {
                        cubit.getEvents(owner: owner);
                      },
                      itemCount:
                          cubit.hasReachedMax
                              ? cubit.events.length
                              : cubit.events.length + 1,
                      itemBuilder: (context, index) {
                        if (index == cubit.events.length) {
                          return const EmitLoadingItem(size: 20);
                        }
                        return EventContainer(
                          eventsEntity: cubit.events[index],
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
