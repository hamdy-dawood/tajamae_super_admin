import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajamae_super_admin/app/caching/shared_prefs.dart';

import '../../domain/repository/base_auth_repository.dart';
import 'login_states.dart';

class LogInCubit extends Cubit<LogInStates> {
  final BaseAuthRepository repo;

  LogInCubit(this.repo) : super(AuthInitial());

  static LogInCubit of(BuildContext context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // ====================== LOGIN ===================== //

  Future login() async {
    if (formKey.currentState!.validate()) {
      emit(LogInLoadingState());

      final response = await repo.logIn(
        userName: userNameController.text,
        password: passwordController.text,
      );
      response.fold(
        (l) {
          emit(LogInFailState(message: l.message));
        },
        (r) async {
          Caching.put(key: "userId", value: r.userId);
          Caching.put(key: "access_token", value: r.accessToken);
          Caching.put(key: "refresh_token", value: r.refreshToken);

          FirebaseMessaging.instance.subscribeToTopic("tajamae_super");
          FirebaseMessaging.instance.subscribeToTopic(r.userId);

          emit(LogInSuccessState());
        },
      );
    }
  }

  //======================= ADD ADMIN ===========================

  final adminFormKey = GlobalKey<FormState>();
  TextEditingController adminFullNameController = TextEditingController();
  TextEditingController adminUserNameController = TextEditingController();
  TextEditingController adminPasswordController = TextEditingController();

  Future addAmin() async {
    if (adminFormKey.currentState!.validate()) {
      emit(AddAdminLoadingState());

      final response = await repo.addAmin(
        fullName: adminFullNameController.text,
        userName: adminUserNameController.text,
        password: adminPasswordController.text,
      );
      response.fold(
        (l) => emit(AddAdminFailState(message: l.message)),
        (r) => emit(AddAdminSuccessState()),
      );
    }
  }

  //===========================================================

  bool isObscure = true;

  void changeVisibility() {
    isObscure = !isObscure;
    emit(ChangeVisibilityState());
  }
}
