abstract class NotificationsEntity {
  final String sId;
  final String title;
  final String body;
  final String target;
  final bool isSeen;
  final String createdAt;

  NotificationsEntity({
    required this.sId,
    required this.title,
    required this.body,
    required this.target,
    required this.isSeen,
    required this.createdAt,
  });
}
