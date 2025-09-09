import '../../domain/entities/notifications_entity.dart';

class NotificationsModel extends NotificationsEntity {
  NotificationsModel({
    required super.sId,
    required super.title,
    required super.body,
    required super.target,
    required super.isSeen,
    required super.createdAt,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        sId: json['_id'],
        title: json['title'] ?? "",
        body: json['body'] ?? "",
        target: json['target'] ?? "",
        isSeen: json['isSeen'] ?? false,
        createdAt: json['createdAt'],
      );
}
