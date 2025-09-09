class ApiConstants {
  static const String baseUrl = '${ApiConstants.baseUrlLink}/api/v1';

  static const String baseUrlLink = 'https://tajamae.iraqsapp.com';

  /// local server test
  // static const String baseUrlLink = 'https://testtajamae.iraqsapp.com';

  /// local
  // static const String baseUrlLink = 'http://192.168.1.62:1012';

  static String refreshTokenUrl = "/auth/refresh-token";
  static String addImageUrl = "/images";
  static String loginUrl = "/auth/login-super";
  static String registerUrl = "/auth/register-admin";
  static String logout = "/auth/register-admin";
  static String checkUserNameUrl = "/auth/is-available";
  static String adminsUrl = "/users/admins";
  static String resetPasswordUrl = "/auth/admin/reset-password";
  static String eventsUrl = "/documents/event";
  static String configUrl = "/config";
  static String notificationsUrl = "/notifications";
}
