import 'package:flutter/material.dart';
import 'package:tajamae_super_admin/app/utils/colors.dart';
import 'package:tajamae_super_admin/app/utils/constance.dart';

import '../caching/shared_prefs.dart';

class SecTabBar extends StatelessWidget {
  const SecTabBar({
    super.key,
    this.tabController,
    this.onTap,
    required this.tabs,
    this.isScrollable = false,
  });

  final TabController? tabController;
  final Function(int)? onTap;
  final List<String> tabs;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: isScrollable,
      tabAlignment: isScrollable ? TabAlignment.start : TabAlignment.fill,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: AppColors.primary,
      indicatorWeight: 2,
      dividerColor: AppColors.transparent,
      labelPadding: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      indicatorPadding: EdgeInsets.zero,
      unselectedLabelColor: AppColors.grey8,
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        fontFamily:
            Caching.getAppLang() == "ar"
                ? AppConstance.appFontName
                : AppConstance.appFontName,
        fontWeight: FontWeight.w300,
      ),
      labelColor: AppColors.primary,
      labelStyle: TextStyle(
        fontSize: 16,
        fontFamily:
            Caching.getAppLang() == "ar"
                ? AppConstance.appFontName
                : AppConstance.appFontName,
        fontWeight: FontWeight.w300,
      ),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: onTap,
      tabs: List.generate(tabs.length, (index) {
        return Tab(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(tabs[index]),
          ),
        );
      }),
    );
  }
}
