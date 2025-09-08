import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tajamae_super_admin/my_app.dart';

import 'app/bloc_observer/bloc_observer.dart';
import 'app/caching/shared_prefs.dart';
import 'app/dependancy_injection/dependancy_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await AppUpdateManager.initialize("com.mdsoft.deyonee", navigatorKey);

  await Future.wait([Caching.init(), setupGetIt()]);
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}
