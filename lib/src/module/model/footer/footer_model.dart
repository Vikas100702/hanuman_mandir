class FooterModel {
  FooterModel({
    required this.statusCode,
    required this.message,
    required this.count,
    required this.data,
  });

  final String? statusCode;
  final String? message;
  final int? count;
  final List<Datum> data;

  factory FooterModel.fromJson(Map<String, dynamic> json){
    return FooterModel(
      statusCode: json["statusCode"],
      message: json["message"],
      count: json["Count"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "Count": count,
    "data": data.map((x) => x?.toJson()).toList(),
  };

}

class Datum {
  Datum({
    required this.id,
    required this.phone,
    required this.email,
    required this.weekdayMorningTime,
    required this.weekDayEveningTime,
    required this.weekEndMorningTime,
    required this.weekEndEveningTime,
    required this.facebookLink,
    required this.twitterLink,
    required this.youtubeLink,
    required this.termsOfUse,
    required this.copyRight,
    required this.securityPage,
    required this.privacyPolicy,
    required this.refDataCode,
    required this.moduleName,
    required this.clientId,
    required this.productId,
    required this.aspectType,
    required this.recCreBy,
    required this.recCreDate,
    required this.recCreTime,
    required this.recModBy,
    required this.recModDate,
    required this.recModTime,
    required this.footerLogo,
    required this.copyRightId,
    required this.emailId,
    required this.facebookLinkId,
    required this.footerLogoId,
    required this.phoneId,
    required this.privacyPolicyId,
    required this.refDataCodeId,
    required this.securityPageId,
    required this.termsOfUseId,
    required this.twitterLinkId,
    required this.weekDayEveningTimeId,
    required this.weekEndEveningTimeId,
    required this.weekEndMorningTimeId,
    required this.weekdayMorningTimeId,
    required this.youtubeLinkId,
    required this.sequenceIdAsNumber,
  });

  final String? id;
  final String? phone;
  final String? email;
  final String? weekdayMorningTime;
  final String? weekDayEveningTime;
  final String? weekEndMorningTime;
  final String? weekEndEveningTime;
  final String? facebookLink;
  final String? twitterLink;
  final String? youtubeLink;
  final String? termsOfUse;
  final String? copyRight;
  final String? securityPage;
  final String? privacyPolicy;
  final String? refDataCode;
  final String? moduleName;
  final String? clientId;
  final String? productId;
  final String? aspectType;
  final String? recCreBy;
  final String? recCreDate;
  final String? recCreTime;
  final String? recModBy;
  final String? recModDate;
  final int? recModTime;
  final String? footerLogo;
  final String? copyRightId;
  final String? emailId;
  final String? facebookLinkId;
  final String? footerLogoId;
  final String? phoneId;
  final String? privacyPolicyId;
  final String? refDataCodeId;
  final String? securityPageId;
  final String? termsOfUseId;
  final String? twitterLinkId;
  final String? weekDayEveningTimeId;
  final String? weekEndEveningTimeId;
  final String? weekEndMorningTimeId;
  final String? weekdayMorningTimeId;
  final String? youtubeLinkId;
  final dynamic sequenceIdAsNumber;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      phone: json["phone"],
      email: json["email"],
      weekdayMorningTime: json["weekdayMorningTime"],
      weekDayEveningTime: json["weekDayEveningTime"],
      weekEndMorningTime: json["weekEndMorningTime"],
      weekEndEveningTime: json["weekEndEveningTime"],
      facebookLink: json["facebookLink"],
      twitterLink: json["twitterLink"],
      youtubeLink: json["youtubeLink"],
      termsOfUse: json["termsOfUse"],
      copyRight: json["copyRight"],
      securityPage: json["securityPage"],
      privacyPolicy: json["privacyPolicy"],
      refDataCode: json["refDataCode"],
      moduleName: json["moduleName"],
      clientId: json["clientID"],
      productId: json["productID"],
      aspectType: json["aspectType"],
      recCreBy: json["recCreBy"],
      recCreDate: json["recCreDate"],
      recCreTime: json["recCreTime"],
      recModBy: json["recModBy"],
      recModDate: json["recModDate"],
      recModTime: json["recModTime"],
      footerLogo: json["footerLogo"],
      copyRightId: json["copyRightId"],
      emailId: json["emailId"],
      facebookLinkId: json["facebookLinkId"],
      footerLogoId: json["footerLogoId"],
      phoneId: json["phoneId"],
      privacyPolicyId: json["privacyPolicyId"],
      refDataCodeId: json["refDataCodeId"],
      securityPageId: json["securityPageId"],
      termsOfUseId: json["termsOfUseId"],
      twitterLinkId: json["twitterLinkId"],
      weekDayEveningTimeId: json["weekDayEveningTimeId"],
      weekEndEveningTimeId: json["weekEndEveningTimeId"],
      weekEndMorningTimeId: json["weekEndMorningTimeId"],
      weekdayMorningTimeId: json["weekdayMorningTimeId"],
      youtubeLinkId: json["youtubeLinkId"],
      sequenceIdAsNumber: json["sequenceIdAsNumber"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "phone": phone,
    "email": email,
    "weekdayMorningTime": weekdayMorningTime,
    "weekDayEveningTime": weekDayEveningTime,
    "weekEndMorningTime": weekEndMorningTime,
    "weekEndEveningTime": weekEndEveningTime,
    "facebookLink": facebookLink,
    "twitterLink": twitterLink,
    "youtubeLink": youtubeLink,
    "termsOfUse": termsOfUse,
    "copyRight": copyRight,
    "securityPage": securityPage,
    "privacyPolicy": privacyPolicy,
    "refDataCode": refDataCode,
    "moduleName": moduleName,
    "clientID": clientId,
    "productID": productId,
    "aspectType": aspectType,
    "recCreBy": recCreBy,
    "recCreDate": recCreDate,
    "recCreTime": recCreTime,
    "recModBy": recModBy,
    "recModDate": recModDate,
    "recModTime": recModTime,
    "footerLogo": footerLogo,
    "copyRightId": copyRightId,
    "emailId": emailId,
    "facebookLinkId": facebookLinkId,
    "footerLogoId": footerLogoId,
    "phoneId": phoneId,
    "privacyPolicyId": privacyPolicyId,
    "refDataCodeId": refDataCodeId,
    "securityPageId": securityPageId,
    "termsOfUseId": termsOfUseId,
    "twitterLinkId": twitterLinkId,
    "weekDayEveningTimeId": weekDayEveningTimeId,
    "weekEndEveningTimeId": weekEndEveningTimeId,
    "weekEndMorningTimeId": weekEndMorningTimeId,
    "weekdayMorningTimeId": weekdayMorningTimeId,
    "youtubeLinkId": youtubeLinkId,
    "sequenceIdAsNumber": sequenceIdAsNumber,
  };

}
