import '../../domain/entities/events_entity.dart';

class EventsModel extends EventsEntity {
  EventsModel({
    required super.sId,
    required super.title,
    required super.startDate,
    required super.endDate,
    required super.startTime,
    required super.endTime,
    required super.timezone,
    required super.showVenue,
    required super.showMap,
    required super.venue,
    required super.country,
    required super.address,
    required super.city,
    required super.zipCode,
    required super.state,
    required super.description,
    required super.registrationEndDate,
    required super.registrationEndTime,
    required super.siteBanner,
    required super.siteLogo,
    required super.thankYouConfirmed,
    required super.thankYouPending,
    required super.qrCodeBanner,
    required super.qrCodeNotes,
    required super.qrCodeTerms,
    required super.owner,
    required super.createdAt,
    required super.updatedAt,
    required super.iV,
    required super.active,
    required super.enableWhatsapp,
    required super.whatsappInstanceId,
    required super.whatsappTokenId,
    required super.emailHost,
    required super.eventEmail,
    required super.emailPass,
    required super.successEmailTitle,
    required super.successEmailMessage,
    required super.reviewEmailTitle,
    required super.reviewEmailMessage,
    required super.imageCaption,
    required super.customDomain,
    required super.employees,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
        sId: json['_id'],
        title: json['title'] ?? "",
        startDate: json['startDate'] ?? "",
        endDate: json['endDate'] ?? "",
        startTime: json['startTime'] ?? "",
        endTime: json['endTime'] ?? "",
        timezone: json['timezone'],
        showVenue: json['showVenue'],
        showMap: json['showMap'],
        venue: json['venue'],
        country: json['country'],
        address: json['address'],
        city: json['city'],
        zipCode: json['zipCode'],
        state: json['state'],
        description: json['description'] == null || json['description'].isEmpty
            ? "<p><br/></p>"
            : json['description'],
        registrationEndDate: json['registrationEndDate'],
        registrationEndTime: json['registrationEndTime'],
        siteBanner: json['siteBanner'],
        siteLogo: json['siteLogo'] ?? "",
        thankYouConfirmed: json['thankYouConfirmed'] == null ||
                json['thankYouConfirmed'].isEmpty
            ? "<p><br/></p>"
            : json['thankYouConfirmed'],
        thankYouPending:
            json['thankYouPending'] == null || json['thankYouPending'].isEmpty
                ? "<p><br/></p>"
                : json['thankYouPending'],
        qrCodeBanner: json['qrCodeBanner'],
        qrCodeNotes: json['qrCodeNotes'] == null || json['qrCodeNotes'].isEmpty
            ? "<p><br/></p>"
            : json['qrCodeNotes'],
        qrCodeTerms: json['qrCodeTerms'] == null || json['qrCodeTerms'].isEmpty
            ? "<p><br/></p>"
            : json['qrCodeTerms'],
        owner: json['owner'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        iV: json['__v'],
        active: json['active'] ?? false,
        enableWhatsapp: json['enableWhatsapp'] ?? false,
        whatsappInstanceId: json['whatsappInstanceId'] ?? "",
        whatsappTokenId: json['whatsappTokenId'] ?? "",
        emailHost: json['emailHost'] ?? "",
        eventEmail: json['eventEmail'] ?? "",
        emailPass: json['emailPass'] ?? "",
        successEmailTitle: json['successEmailTitle'] ?? "",
        successEmailMessage: json['successEmailMessage'] ?? "",
        reviewEmailTitle: json['reviewEmailTitle'] ?? "",
        reviewEmailMessage: json['reviewEmailMessage'] ?? "",
        imageCaption: json['imageCaption'] ?? "",
        customDomain: json['customDomain'] ?? "",
        employees: List<String>.from((json["employees"] ?? []).map((x) => x)),
      );
}
