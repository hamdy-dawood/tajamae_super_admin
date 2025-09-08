import 'package:tajamae_super_admin/features/home/domain/entities/user_entity.dart';

class UserDataModel extends UserDataEntity {
  UserDataModel({
    required super.id,
    required super.userName,
    required super.displayName,
    required super.role,
    required super.active,
    required super.deleted,
    required super.expireDate,
    required super.createdAt,
    required super.updatedAt,
    required super.v,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    id: json["_id"],
    userName: json["userName"],
    displayName: json["displayName"],
    role: json["role"],
    active: json["active"],
    deleted: json["deleted"],
    expireDate: DateTime.parse(json["expireDate"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );
}
