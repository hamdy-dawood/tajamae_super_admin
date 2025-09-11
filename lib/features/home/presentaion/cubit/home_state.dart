part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

///============================ GET NOTIFICATIONS COUNT ==================//

class GetNotificationsCountSuccessState extends HomeState {}

class GetNotificationsCountFailState extends HomeState {
  final String message;

  GetNotificationsCountFailState({required this.message});
}

///============================ SEEN NOTIFICATIONS ==================//

class SeenNotificationsLoadingState extends HomeState {}

class SeenNotificationsSuccessState extends HomeState {}

class SeenNotificationsFailState extends HomeState {
  final String message;

  SeenNotificationsFailState({required this.message});
}

///============================ GET ACCOUNTS COUNT ==================//

class GetAccountCountLoadingState extends HomeState {}

class GetAccountCountSuccessState extends HomeState {}

class GetAccountCountFailState extends HomeState {
  final String message;

  GetAccountCountFailState({required this.message});
}

/// ======================== GET USERS ==================//

class GetUsersLoadingState extends HomeState {}

class GetUsersMoreLoadingState extends HomeState {}

class GetUsersSuccessState extends HomeState {}

class GetUsersFailState extends HomeState {
  final String message;

  GetUsersFailState({required this.message});
}

/// ========================= Activation Account ==================//

class ActivationAccountLoadingState extends HomeState {}

class ActivationAccountSuccessState extends HomeState {}

class ActivationAccountFailState extends HomeState {
  final String message;

  ActivationAccountFailState({required this.message});
}

/// =========================== Edit Expire Date==================//

class EditExpireDateLoadingState extends HomeState {}

class EditExpireDateSuccessState extends HomeState {}

class EditExpireDateFailState extends HomeState {
  final String message;

  EditExpireDateFailState({required this.message});
}

/// =========================== RESET PASSWORD ==================//

class ResetPasswordLoadingState extends HomeState {}

class ResetPasswordSuccessState extends HomeState {}

class ResetPasswordFailState extends HomeState {
  final String message;

  ResetPasswordFailState({required this.message});
}

/// =========================== LogOut ==================//

class LogOutLoadingState extends HomeState {}

class LogOutSuccessState extends HomeState {}

class LogOutFailState extends HomeState {
  final String message;

  LogOutFailState({required this.message});
}

///===================== CONFIG ========================//

class GetConfigLoadingState extends HomeState {}

class GetConfigSuccessState extends HomeState {}

class GetConfigFailState extends HomeState {
  final String message;

  GetConfigFailState({required this.message});
}

class EditConfigLoadingState extends HomeState {}

class EditConfigSuccessState extends HomeState {}

class EditConfigFailState extends HomeState {
  final String message;

  EditConfigFailState({required this.message});
}

/// ======================== GET EVENTS ==================//

class GetNotificationsLoadingState extends HomeState {}

class GetNotificationsMoreLoadingState extends HomeState {}

class GetNotificationsSuccessState extends HomeState {}

class GetNotificationsFailState extends HomeState {
  final String message;

  GetNotificationsFailState({required this.message});
}

/// ======================== GET EVENTS ==================//

class GetEventsLoadingState extends HomeState {}

class GetEventsMoreLoadingState extends HomeState {}

class GetEventsSuccessState extends HomeState {}

class GetEventsFailState extends HomeState {
  final String message;

  GetEventsFailState({required this.message});
}
//==================================================

class ChangeMonthState extends HomeState {}

class ChangePressDateState extends HomeState {}

class UpdateDateStates extends HomeState {}
