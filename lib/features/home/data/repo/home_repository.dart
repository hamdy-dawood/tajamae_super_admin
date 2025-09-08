import 'package:dartz/dartz.dart';
import 'package:tajamae_super_admin/app/errors/server_errors.dart';
import 'package:tajamae_super_admin/features/home/data/data_source/base_remote_home_data_source.dart';
import 'package:tajamae_super_admin/features/home/domain/entities/user_entity.dart';
import 'package:tajamae_super_admin/features/home/domain/repositories/base_home_repository.dart';

import '../../domain/entities/events_entity.dart';

class HomeRepository extends BaseHomeRepository {
  final BaseRemoteHomeDataSource dataSource;

  HomeRepository(this.dataSource);

  @override
  Future<Either<ServerError, List<UserDataEntity>>> getUsers({
    required int page,
    required String searchText,
  }) async {
    try {
      final result = await dataSource.getUsers(
        page: page,
        searchText: searchText,
      );
      return Right(result);
    } on ServerError catch (fail) {
      return Left(fail);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }


  @override
  Future<Either<ServerError, void>> editAccount({
    required String id,
    required Map<String, dynamic> map,
  }) async {
    try {
      final result = await dataSource.editAccount(id: id, map: map);
      return Right(result);
    } on ServerError catch (fail) {
      return Left(fail);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }


  @override
  Future<Either<ServerError, void>> resetPassword({
    required Map<String, dynamic> map,
  }) async {
    try {
      final result = await dataSource.resetPassword(map: map);
      return Right(result);
    } on ServerError catch (fail) {
      return Left(fail);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<ServerError, void>> logOut() async {
    try {
      final result = await dataSource.logOut();
      return Right(result);
    } on ServerError catch (fail) {
      return Left(fail);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }


  @override
  Future<Either<ServerError, List<EventsEntity>>> getEvents({
    required int page,
    required String owner,
    required String searchText,
  }) async {
    try {
      final result = await dataSource.getEvents(
        page: page,
        owner: owner,
        searchText: searchText,
      );
      return Right(result);
    } on ServerError catch (fail) {
      return Left(fail);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

}
