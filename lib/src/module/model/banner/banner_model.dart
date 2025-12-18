class BannerModel {
  BannerModel({
    required this.statusCode,
    required this.message,
    required this.count,
    required this.data,
  });

  final String? statusCode;
  final String? message;
  final int? count;
  final List<Datum> data;

  factory BannerModel.fromJson(Map<String, dynamic> json){
    return BannerModel(
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
    required this.bannerType,
    required this.refDataName,
    required this.altName,
    required this.bannerDesc,
    required this.bannerHeading,
    required this.bannerSubHeading,
    required this.bannerButtonLink,
    required this.moduleName,
    required this.clientId,
    required this.productId,
    required this.aspectType,
    required this.recCreBy,
    required this.recCreDate,
    required this.recCreTime,
    required this.insertedId,
    required this.recModBy,
    required this.recModDate,
    required this.recModTime,
    required this.altNameId,
    required this.bannerButtonLinkId,
    required this.bannerDescId,
    required this.bannerHeadingId,
    required this.bannerSubHeadingId,
    required this.bannerTypeId,
    required this.refDataNameId,
    required this.status,
    required this.statusId,
    required this.sequenceIdAsNumber,
    required this.sequenceId,
    required this.sequenceIdId,
  });

  final String? id;
  final String? bannerType;
  final String? refDataName;
  final String? altName;
  final String? bannerDesc;
  final String? bannerHeading;
  final String? bannerSubHeading;
  final String? bannerButtonLink;
  final String? moduleName;
  final String? clientId;
  final String? productId;
  final String? aspectType;
  final String? recCreBy;
  final String? recCreDate;
  final int? recCreTime;
  final String? insertedId;
  final String? recModBy;
  final String? recModDate;
  final int? recModTime;
  final String? altNameId;
  final String? bannerButtonLinkId;
  final String? bannerDescId;
  final String? bannerHeadingId;
  final String? bannerSubHeadingId;
  final String? bannerTypeId;
  final String? refDataNameId;
  final String? status;
  final String? statusId;
  final int? sequenceIdAsNumber;
  final String? sequenceId;
  final String? sequenceIdId;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      bannerType: json["bannerType"],
      refDataName: json["refDataName"],
      altName: json["altName"],
      bannerDesc: json["bannerDesc"],
      bannerHeading: json["bannerHeading"],
      bannerSubHeading: json["bannerSubHeading"],
      bannerButtonLink: json["bannerButtonLink"],
      moduleName: json["moduleName"],
      clientId: json["clientID"],
      productId: json["productID"],
      aspectType: json["aspectType"],
      recCreBy: json["recCreBy"],
      recCreDate: json["recCreDate"],
      recCreTime: json["recCreTime"],
      insertedId: json["insertedId"],
      recModBy: json["recModBy"],
      recModDate: json["recModDate"],
      recModTime: json["recModTime"],
      altNameId: json["altNameId"],
      bannerButtonLinkId: json["bannerButtonLinkId"],
      bannerDescId: json["bannerDescId"],
      bannerHeadingId: json["bannerHeadingId"],
      bannerSubHeadingId: json["bannerSubHeadingId"],
      bannerTypeId: json["bannerTypeId"],
      refDataNameId: json["refDataNameId"],
      status: json["status"],
      statusId: json["statusId"],
      sequenceIdAsNumber: json["sequenceIdAsNumber"],
      sequenceId: json["sequenceId"],
      sequenceIdId: json["sequenceIdId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bannerType": bannerType,
    "refDataName": refDataName,
    "altName": altName,
    "bannerDesc": bannerDesc,
    "bannerHeading": bannerHeading,
    "bannerSubHeading": bannerSubHeading,
    "bannerButtonLink": bannerButtonLink,
    "moduleName": moduleName,
    "clientID": clientId,
    "productID": productId,
    "aspectType": aspectType,
    "recCreBy": recCreBy,
    "recCreDate": recCreDate,
    "recCreTime": recCreTime,
    "insertedId": insertedId,
    "recModBy": recModBy,
    "recModDate": recModDate,
    "recModTime": recModTime,
    "altNameId": altNameId,
    "bannerButtonLinkId": bannerButtonLinkId,
    "bannerDescId": bannerDescId,
    "bannerHeadingId": bannerHeadingId,
    "bannerSubHeadingId": bannerSubHeadingId,
    "bannerTypeId": bannerTypeId,
    "refDataNameId": refDataNameId,
    "status": status,
    "statusId": statusId,
    "sequenceIdAsNumber": sequenceIdAsNumber,
    "sequenceId": sequenceId,
    "sequenceIdId": sequenceIdId,
  };

}