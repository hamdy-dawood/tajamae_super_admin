import 'package:tajamae_super_admin/features/home/data/models/user_model.dart';

import '../models/events_model.dart';

abstract class BaseRemoteHomeDataSource {
  Future<List<UserDataModel>> getUsers({
    required int page,
    required String searchText,
  });


  Future<void> editAccount({
    required String id,
    required Map<String, dynamic> map,
  });

  Future<void> resetPassword({
    required Map<String, dynamic> map,
  });

  Future<void> logOut();


  Future<List<EventsModel>> getEvents({
    required int page,
    required String owner,

    required String searchText,
  });

}
