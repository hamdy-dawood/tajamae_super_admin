import 'package:dio/dio.dart';
import 'package:tajamae_super_admin/app/network/dio.dart';
import 'package:tajamae_super_admin/app/network/end_points.dart';

import '../models/login_model.dart';
import 'base_remote_auth_data_source.dart';

class RemoteAuthDataSource extends BaseRemoteAuthDataSource {
  final dioManager = DioManager();

  @override
  Future<UserModel> logIn({
    required String userName,
    required String password,
  }) async {
    final Response response = await dioManager.post(
      ApiConstants.loginUrl,
      data: {"userName": userName, "password": password},
    );
    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> addAmin({
    required String fullName,
    required String userName,
    required String password,
  }) async {
    await dioManager.post(
      ApiConstants.registerUrl,
      data: {
        "displayName": fullName,
        "userName": userName,
        "password": password
      },
    );
  }
}
