import 'package:dio/dio.dart';
import 'package:tajamae_super_admin/features/login/presentation/screens/login_screen.dart';

import '../caching/shared_prefs.dart';
import '../helper/extension.dart';
import 'end_points.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors({required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? authToken = Caching.get(key: "access_token");
    if (authToken != null && authToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $authToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      String? accessToken = Caching.get(key: "access_token");
      String? refreshToken = Caching.get(key: "refresh_token");
      if (refreshToken != null && refreshToken.isNotEmpty) {
        await dio
            .get(
              ApiConstants.refreshTokenUrl,
              queryParameters: {"token": refreshToken},
            )
            .then((value) {
              String accessToken = value.data["accesstoken"];
              Caching.put(key: "access_token", value: accessToken);
            });
        accessToken = Caching.get(key: "access_token");
        err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
        return handler.resolve(await dio.fetch(err.requestOptions));
      }
    } else if (err.response?.statusCode == 403) {
      Caching.clearAllData();
      MagicRouter.navigateTo(page: LoginScreen(), withHistory: false);
    }
    super.onError(err, handler);
  }
}
