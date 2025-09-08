import 'package:dio/dio.dart';
import 'package:tajamae_super_admin/app/caching/shared_prefs.dart';
import 'package:tajamae_super_admin/app/network/dio.dart';
import 'package:tajamae_super_admin/app/network/end_points.dart';
import 'package:tajamae_super_admin/features/home/data/models/user_model.dart';

import '../models/events_model.dart';
import 'base_remote_home_data_source.dart';

class RemoteHomeDataSource extends BaseRemoteHomeDataSource {
  final dioManager = DioManager();

  @override
  Future<List<UserDataModel>> getUsers({
    required int page,
    required String searchText,
  }) async {
    final Response response = await dioManager.get(
      ApiConstants.adminsUrl,
      queryParameters: {
        "page": page,
        if (searchText.isNotEmpty) 'searchText': searchText.trim(),
      },
    );
    return List<UserDataModel>.from(
      (response.data['result'] as List).map(
        (e) => UserDataModel.fromJson(e),
      ),
    );
  }


  @override
  Future<void> editAccount({
    required String id,
    required Map<String, dynamic> map,
  }) async {
    await dioManager.put('${ApiConstants.adminsUrl}/$id', data: map);
  }

  @override
  Future<void> resetPassword({
    required Map<String, dynamic> map,
  }) async {
    await dioManager.post(ApiConstants.resetPasswordUrl, data: map);
  }

  @override
  Future<void> logOut() async {
    await dioManager.post(
      ApiConstants.logout,
      data: {"token": Caching.get(key: 'access_token')},
    );
  }

  @override
  Future<List<EventsModel>> getEvents({
    required int page,
    required String owner,
    required String searchText,
  }) async {
    final Response response = await dioManager.get(
      ApiConstants.eventsUrl,
      queryParameters: {
        "page": page,
        "owner": owner,
        if (searchText.isNotEmpty) 'searchText': searchText.trim(),
      },
    );
    return List<EventsModel>.from(
      (response.data['result'] as List).map(
            (e) => EventsModel.fromJson(e),
      ),
    );
  }

}
