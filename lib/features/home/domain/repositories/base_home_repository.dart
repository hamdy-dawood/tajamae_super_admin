import 'package:dartz/dartz.dart';
import 'package:tajamae_super_admin/app/errors/server_errors.dart';
import 'package:tajamae_super_admin/features/home/domain/entities/user_entity.dart';

import '../entities/events_entity.dart';
import '../entities/notifications_entity.dart';

abstract class BaseHomeRepository {
  Future<Either<ServerError, List<UserDataEntity>>> getUsers({
    required int page,
    required String searchText,
  });

  Future<Either<ServerError, void>> editAccount({
    required String id,
    required Map<String, dynamic> map,
  });

  Future<Either<ServerError, void>> resetPassword({
    required Map<String, dynamic> map,
  });

  Future<Either<ServerError, void>> logOut();

  Future<Either<ServerError, List<NotificationsEntity>>> getNotifications({
    required int page,
  });

  Future<Either<ServerError, List<EventsEntity>>> getEvents({
    required int page,
    required String owner,
    required String searchText,
  });

}
