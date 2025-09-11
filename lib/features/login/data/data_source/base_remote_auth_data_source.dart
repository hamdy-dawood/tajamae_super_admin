import '../models/login_model.dart';

abstract class BaseRemoteAuthDataSource {
  Future<UserModel> logIn({
    required String userName,
    required String password,
  });

  Future<void> addAmin({
    required String fullName,
    required String userName,
    required String password,
  });
}
