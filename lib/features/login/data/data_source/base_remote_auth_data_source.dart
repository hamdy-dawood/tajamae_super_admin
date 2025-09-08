import '../models/login_model.dart';

abstract class BaseRemoteAuthDataSource {
  Future<UserModel> logIn({required String userName, required String password});
}
