import '../../domain/entities/login_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.userId,

    required super.accessToken,
    required super.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["userId"],
      accessToken: json["accesstoken"],
      refreshToken: json["refreshtoken"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "accessToken": accessToken,
      "refreshToken": refreshToken,
    };
  }
}
