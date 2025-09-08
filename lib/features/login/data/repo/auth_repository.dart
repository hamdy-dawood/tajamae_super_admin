import 'package:dartz/dartz.dart';
import 'package:tajamae_super_admin/app/errors/server_errors.dart';

import '../../domain/entities/login_entity.dart';
import '../../domain/repository/base_auth_repository.dart';
import '../data_source/base_remote_auth_data_source.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseRemoteAuthDataSource dataSource;

  AuthRepository(this.dataSource);

  @override
  Future<Either<ServerError, UserEntity>> logIn({
    required String userName,
    required String password,
  }) async {
    try {
      final result = await dataSource.logIn(
        userName: userName,
        password: password,
      );
      return Right(result);
    } on ServerError catch (fail) {
      return Left(fail);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
