import 'package:get_it/get_it.dart';
import 'package:tajamae_super_admin/features/home/data/data_source/base_remote_home_data_source.dart';
import 'package:tajamae_super_admin/features/home/data/data_source/remote_home_data_source.dart';
import 'package:tajamae_super_admin/features/home/data/repo/home_repository.dart';
import 'package:tajamae_super_admin/features/home/domain/repositories/base_home_repository.dart';
import 'package:tajamae_super_admin/features/home/presentaion/cubit/home_cubit.dart';
import 'package:tajamae_super_admin/features/login/data/data_source/base_remote_auth_data_source.dart';
import 'package:tajamae_super_admin/features/login/data/data_source/remote_auth_data_source.dart';
import 'package:tajamae_super_admin/features/login/data/repo/auth_repository.dart';
import 'package:tajamae_super_admin/features/login/domain/repository/base_auth_repository.dart';
import 'package:tajamae_super_admin/features/login/presentation/cubit/login_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Auth
  getIt.registerLazySingleton<BaseRemoteAuthDataSource>(
    () => RemoteAuthDataSource(),
  );
  getIt.registerLazySingleton<BaseAuthRepository>(
    () => AuthRepository(getIt()),
  );
  getIt.registerFactory<LogInCubit>(() => LogInCubit(getIt()));

  //home
  getIt.registerLazySingleton<BaseRemoteHomeDataSource>(
    () => RemoteHomeDataSource(),
  );
  getIt.registerLazySingleton<BaseHomeRepository>(
    () => HomeRepository(getIt()),
  );
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
}
