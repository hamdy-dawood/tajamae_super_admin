abstract class LogInStates {}

class AuthInitial extends LogInStates {}

class LogInLoadingState extends LogInStates {}

class LogInSuccessState extends LogInStates {}

class LogInFailState extends LogInStates {
  final String message;

  LogInFailState({required this.message});
}

//======================= ADD ADMIN ===========================

class AddAdminLoadingState extends LogInStates {}

class AddAdminSuccessState extends LogInStates {}

class AddAdminFailState extends LogInStates {
  final String message;

  AddAdminFailState({required this.message});
}

//==============================================================

class ChangeVisibilityState extends LogInStates {}
