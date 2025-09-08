import '../../domain/entities/events_entity.dart';

class EventsModel extends EventsEntity {
  EventsModel({
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

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
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
