abstract class UserDataEntity {
  final String id;
  final String userName;
  final String displayName;
  final String role;
  final bool active;
  final bool deleted;
  final DateTime expireDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  UserDataEntity({
    required this.id,
    required this.userName,
    required this.displayName,
    required this.role,
    required this.active,
    required this.deleted,
    required this.expireDate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
}
