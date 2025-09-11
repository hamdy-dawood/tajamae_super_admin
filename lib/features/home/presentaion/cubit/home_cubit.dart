import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tajamae_super_admin/app/network/dio.dart';
import 'package:tajamae_super_admin/app/network/end_points.dart';
import 'package:tajamae_super_admin/features/home/domain/entities/user_entity.dart';
import 'package:tajamae_super_admin/features/home/domain/repositories/base_home_repository.dart';

import '../../domain/entities/events_entity.dart';
import '../../domain/entities/notifications_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repo) : super(HomeInitial());
  BaseHomeRepository repo;

  ///======================== GET NOTIFICATIONS COUNT ========================///

  int count = 0;

  Future<void> getNotificationsCount() async {
    try {
      final response = await dioManager.get(
        ApiConstants.notificationCountUrl,
        queryParameters: {"isSeen": false},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data != null) {
          count = data["count"] ?? 0;
        }

        emit(GetNotificationsCountSuccessState());
      } else {
        emit(GetNotificationsCountFailState(message: "${response.statusCode}"));
      }
    } on DioException catch (e) {
      emit(GetNotificationsCountFailState(message: e.message ?? ""));
    } catch (e) {
      emit(GetNotificationsCountFailState(message: 'An unknown error: $e'));
    }
  }

  ///======================== SEEN NOTIFICATIONS ========================///

  Future<void> seenNotifications() async {
    emit(SeenNotificationsLoadingState());
    try {
      final response = await dioManager.post(
        ApiConstants.notificationSeenUrl,
        data: {"isSeen": true},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        count = 0;
        emit(SeenNotificationsSuccessState());
        clearNotificationsData();
        getNotifications();
      } else {
        emit(SeenNotificationsFailState(message: "${response.statusCode}"));
      }
    } on DioException catch (e) {
      emit(SeenNotificationsFailState(message: e.message ?? ""));
    } catch (e) {
      emit(SeenNotificationsFailState(message: 'An unknown error: $e'));
    }
  }

  ///======================== GET ACCOUNTS =========================///

  int page = 1;
  bool hasReachedMax = false;
  List<UserDataEntity> users = [];

  UserDataEntity? accountEntity;
  TextEditingController searchController = TextEditingController();

  Future<void> getUsers() async {
    if (hasReachedMax) {
      return;
    }
    page == 1 ? emit(GetUsersLoadingState()) : emit(GetUsersMoreLoadingState());
    final query = searchController.text.trim();
    final response = await repo.getUsers(page: page, searchText: query);

    response.fold((l) => emit(GetUsersFailState(message: l.message)), (r) {
      if (r.isEmpty && page == 1) {
        emit(GetUsersSuccessState());
        return;
      }

      if (r.isEmpty || r.length < 20) {
        hasReachedMax = true;
        users.addAll(r);
        emit(GetUsersSuccessState());
        return;
      }
      page == 1 ? users = r : users.addAll(r);

      page++;
      emit(GetUsersSuccessState());
    });
  }

  //=============================================

  clearUsersData() {
    page = 1;
    hasReachedMax = false;
    users.clear();
  }

  ///======================== activation =========================///

  Future<void> activationAccount({
    required String id,
    required String active,
  }) async {
    emit(ActivationAccountLoadingState());
    final response = await repo.editAccount(id: id, map: {'active': active});

    response.fold((l) => emit(ActivationAccountFailState(message: l.message)), (
      r,
    ) {
      emit(ActivationAccountSuccessState());
    });
  }

  ///======================== editExpireDate =========================///

  final dialogEditExpireDateFormKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();

  Future<void> editExpireDate({required String id}) async {
    emit(EditExpireDateLoadingState());
    final response = await repo.editAccount(
      id: id,
      map: {'expireDate': "${dateController.text}"},
    );

    response.fold((l) => emit(EditExpireDateFailState(message: l.message)), (
      r,
    ) {
      emit(EditExpireDateSuccessState());
    });
  }

  ///======================== editExpireDate =========================///

  final resetPasswordFormKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();

  Future<void> resetPassword({required String id}) async {
    emit(ResetPasswordLoadingState());
    final response = await repo.resetPassword(
      map: {"id": id, "newPassword": passwordController.text},
    );

    response.fold((l) => emit(ResetPasswordFailState(message: l.message)), (r) {
      emit(ResetPasswordSuccessState());
    });
  }

  /// DATE =====================================

  void pressDate(
    BuildContext context, {
    TextEditingController? controller,
    required void Function(String) onDateSelected,
    required void Function(DateTime) onDateSelectedDate,
  }) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 18000)),
      lastDate: DateTime.now().add(const Duration(days: 3600)),
    );

    if (date != null) {
      String formattedDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      String dateMillis = date.millisecondsSinceEpoch.toString();

      onDateSelectedDate(date);
      onDateSelected(dateMillis);

      if (controller != null) {
        controller.text = formattedDate;
      }

      emit(UpdateDateStates());
    }
  }

  /// =========================== LogOut ==================//

  Future logout() async {
    emit(LogOutLoadingState());
    final response = await repo.logOut();
    response.fold(
      (l) {
        emit(LogOutFailState(message: l.message));
      },
      (r) async {
        emit(LogOutSuccessState());
      },
    );
  }

  /// =========================== CONFIG ==================//

  final dioManager = DioManager();

  TextEditingController barcodeLicenseController = TextEditingController();

  Future<void> getConfig() async {
    emit(GetConfigLoadingState());
    try {
      final response = await dioManager.get(ApiConstants.configUrl);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data != null) {
          barcodeLicenseController.text = data["qrCode"] ?? "";
        }

        emit(GetConfigSuccessState());
      } else {
        emit(GetConfigFailState(message: "${response.statusCode}"));
      }
    } on DioException catch (e) {
      emit(GetConfigFailState(message: e.message ?? ""));
    } catch (e) {
      emit(GetConfigFailState(message: 'An unknown error: $e'));
    }
  }

  Future<void> editConfig() async {
    emit(EditConfigLoadingState());
    try {
      final response = await dioManager.put(
        ApiConstants.configUrl,
        data: {"qrCode": barcodeLicenseController.text},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data != null) {
          barcodeLicenseController.text = data["qrCode"] ?? "";
        }

        emit(EditConfigSuccessState());
      } else {
        emit(EditConfigFailState(message: "${response.statusCode}"));
      }
    } on DioException catch (e) {
      emit(EditConfigFailState(message: e.message ?? ""));
    } catch (e) {
      emit(EditConfigFailState(message: 'An unknown error: $e'));
    }
  }

  ///======================== GET NOTIFICATIONS =========================///

  int notificationPage = 1;
  bool notificationHasReachedMax = false;
  List<NotificationsEntity> notifications = [];

  Future<void> getNotifications() async {
    if (notificationHasReachedMax) {
      return;
    }
    notificationPage == 1
        ? emit(GetNotificationsLoadingState())
        : emit(GetNotificationsMoreLoadingState());

    final response = await repo.getNotifications(page: notificationPage);

    response.fold((l) => emit(GetNotificationsFailState(message: l.message)), (
      r,
    ) {
      if (r.isEmpty && notificationPage == 1) {
        emit(GetNotificationsSuccessState());
        return;
      }

      if (r.isEmpty || r.length < 20) {
        notificationHasReachedMax = true;
        notifications.addAll(r);
        emit(GetNotificationsSuccessState());
        return;
      }
      notificationPage == 1 ? notifications = r : notifications.addAll(r);

      notificationPage++;
      emit(GetNotificationsSuccessState());
    });
  }

  //=============================================

  clearNotificationsData() {
    notificationPage = 1;
    notificationHasReachedMax = false;
    notifications.clear();
  }

  ///======================== GET EVENTS =========================///

  int eventPage = 1;
  bool eventHasReachedMax = false;
  List<EventsEntity> events = [];

  TextEditingController eventSearchController = TextEditingController();

  Future<void> getEvents({required String owner}) async {
    if (eventHasReachedMax) {
      return;
    }
    eventPage == 1
        ? emit(GetEventsLoadingState())
        : emit(GetEventsMoreLoadingState());

    final query = eventSearchController.text.trim();

    final response = await repo.getEvents(
      owner: owner,
      page: eventPage,
      searchText: query,
    );

    response.fold((l) => emit(GetEventsFailState(message: l.message)), (r) {
      if (r.isEmpty && eventPage == 1) {
        emit(GetEventsSuccessState());
        return;
      }

      if (r.isEmpty || r.length < 20) {
        eventHasReachedMax = true;
        events.addAll(r);
        emit(GetEventsSuccessState());
        return;
      }
      eventPage == 1 ? events = r : events.addAll(r);

      eventPage++;
      emit(GetEventsSuccessState());
    });
  }

  //=============================================

  clearEventsData() {
    eventPage = 1;
    eventHasReachedMax = false;
    events.clear();
  }
}
