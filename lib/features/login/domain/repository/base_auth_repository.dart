import 'package:dartz/dartz.dart';
import 'package:tajamae_super_admin/app/errors/server_errors.dart';

import '../entities/login_entity.dart';

abstract class BaseAuthRepository {
  Future<Either<ServerError, UserEntity>> logIn({
    required String userName,
    required String password,
  });

  Future<Either<ServerError, void>> addAmin({
    required String fullName,
    required String userName,
    required String password,
  });
}
