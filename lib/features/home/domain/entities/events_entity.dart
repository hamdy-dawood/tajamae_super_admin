abstract class EventsEntity {
  final String sId;
  final String title;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String timezone;
  final bool showVenue;
  final bool showMap;
  final String venue;
  final String country;
  final String address;
  final String city;
  final String zipCode;
  final String state;
  final String description;
  final String registrationEndDate;
  final String registrationEndTime;
  final String siteBanner;
  final String siteLogo;
  final String thankYouConfirmed;
  final String thankYouPending;
  final String qrCodeBanner;
  final String qrCodeNotes;
  final String qrCodeTerms;
  final String owner;
  final String createdAt;
  final String updatedAt;
  final int iV;
  final bool active;
  final bool enableWhatsapp;
  final String whatsappInstanceId;
  final String whatsappTokenId;
  final String emailHost;
  final String eventEmail;
  final String emailPass;
  final String successEmailTitle;
  final String successEmailMessage;
  final String reviewEmailTitle;
  final String reviewEmailMessage;
  final String imageCaption;
  final String customDomain;
  final List<String> employees;

  EventsEntity({
    required this.sId,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.timezone,
    required this.showVenue,
    required this.showMap,
    required this.venue,
    required this.country,
    required this.address,
    required this.city,
    required this.zipCode,
    required this.state,
    required this.description,
    required this.registrationEndDate,
    required this.registrationEndTime,
    required this.siteBanner,
    required this.siteLogo,
    required this.thankYouConfirmed,
    required this.thankYouPending,
    required this.qrCodeBanner,
    required this.qrCodeNotes,
    required this.qrCodeTerms,
    required this.owner,
    required this.createdAt,
    required this.updatedAt,
    required this.iV,
    required this.active,
    required this.enableWhatsapp,
    required this.whatsappInstanceId,
    required this.whatsappTokenId,
    required this.emailHost,
    required this.eventEmail,
    required this.emailPass,
    required this.successEmailTitle,
    required this.successEmailMessage,
    required this.reviewEmailTitle,
    required this.reviewEmailMessage,
    required this.imageCaption,
    required this.customDomain,
    required this.employees,
  });
}
