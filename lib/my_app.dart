import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tajamae_super_admin/features/home/presentaion/screens/home_screen.dart';
import 'package:tajamae_super_admin/features/login/presentation/screens/login_screen.dart';

import 'app/caching/shared_prefs.dart';
import 'app/helper/extension.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String token = Caching.get(key: "access_token") ?? "";
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: MaterialApp(
          locale: const Locale('ar'),
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          title: 'ديوني ادمن',
          navigatorKey: navigatorKey,
          home: token.isNotEmpty ? HomeScreen() : const LoginScreen(),
        ),
      ),
    );
  }
}
