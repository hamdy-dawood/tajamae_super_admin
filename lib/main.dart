import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tajamae_super_admin/my_app.dart';

import 'app/bloc_observer/bloc_observer.dart';
import 'app/caching/shared_prefs.dart';
import 'app/dependancy_injection/dependancy_injection.dart';
import 'app/helper/notification_helper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([Caching.init(), setupGetIt()]);
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());

  _initializeApp();
}

Future<void> _initializeApp() async {
  await Firebase.initializeApp(
    name: "firebase-tajamae-super-admin",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeNotificationServices();
}
