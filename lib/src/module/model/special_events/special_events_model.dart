class SpecialEventsModel {
  SpecialEventsModel({
    required this.statusCode,
    required this.message,
    required this.count,
    required this.data,
  });

  final String? statusCode;
  final String? message;
  final int? count;
  final List<Datum> data;

  factory SpecialEventsModel.fromJson(Map<String, dynamic> json){
    return SpecialEventsModel(
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
    required this.refDataName,
    required this.image,
    required this.pdf,
    required this.sequenceId,
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
    required this.imageId,
    required this.pdfId,
    required this.refDataNameId,
    required this.sequenceIdId,
    required this.flyerLink,
    required this.flyerLinkId,
    required this.endDate,
    required this.endDateId,
    required this.startDate,
    required this.startDateId,
    required this.status,
    required this.statusId,
    required this.eventLink,
    required this.eventLinkId,
    required this.flyerLink2,
    required this.flyerLink2Id,
    required this.flyerLink3,
    required this.flyerLink3Id,
    required this.flyerName,
    required this.flyerName2,
    required this.flyerName2Id,
    required this.flyerName3,
    required this.flyerName3Id,
    required this.flyerNameId,
    required this.qrCode,
    required this.qrCodeId,
    required this.sequenceIdAsNumber,
  });

  final String? id;
  final String? refDataName;
  final String? image;
  final String? pdf;
  final String? sequenceId;
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
  final String? imageId;
  final String? pdfId;
  final String? refDataNameId;
  final String? sequenceIdId;
  final String? flyerLink;
  final String? flyerLinkId;
  final String? endDate;
  final String? endDateId;
  final String? startDate;
  final String? startDateId;
  final String? status;
  final String? statusId;
  final String? eventLink;
  final String? eventLinkId;
  final String? flyerLink2;
  final String? flyerLink2Id;
  final String? flyerLink3;
  final String? flyerLink3Id;
  final String? flyerName;
  final String? flyerName2;
  final String? flyerName2Id;
  final String? flyerName3;
  final String? flyerName3Id;
  final String? flyerNameId;
  final String? qrCode;
  final String? qrCodeId;
  final int? sequenceIdAsNumber;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      refDataName: json["refDataName"],
      image: json["Image"],
      pdf: json["PDF"],
      sequenceId: json["sequenceId"],
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
      imageId: json["ImageId"],
      pdfId: json["PDFId"],
      refDataNameId: json["refDataNameId"],
      sequenceIdId: json["sequenceIdId"],
      flyerLink: json["flyerLink"],
      flyerLinkId: json["flyerLinkId"],
      endDate: json["endDate"],
      endDateId: json["endDateId"],
      startDate: json["startDate"],
      startDateId: json["startDateId"],
      status: json["status"],
      statusId: json["statusId"],
      eventLink: json["eventLink"],
      eventLinkId: json["eventLinkId"],
      flyerLink2: json["flyerLink2"],
      flyerLink2Id: json["flyerLink2Id"],
      flyerLink3: json["flyerLink3"],
      flyerLink3Id: json["flyerLink3Id"],
      flyerName: json["flyerName"],
      flyerName2: json["flyerName2"],
      flyerName2Id: json["flyerName2Id"],
      flyerName3: json["flyerName3"],
      flyerName3Id: json["flyerName3Id"],
      flyerNameId: json["flyerNameId"],
      qrCode: json["qrCode"],
      qrCodeId: json["qrCodeId"],
      sequenceIdAsNumber: json["sequenceIdAsNumber"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "refDataName": refDataName,
    "Image": image,
    "PDF": pdf,
    "sequenceId": sequenceId,
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
    "ImageId": imageId,
    "PDFId": pdfId,
    "refDataNameId": refDataNameId,
    "sequenceIdId": sequenceIdId,
    "flyerLink": flyerLink,
    "flyerLinkId": flyerLinkId,
    "endDate": endDate,
    "endDateId": endDateId,
    "startDate": startDate,
    "startDateId": startDateId,
    "status": status,
    "statusId": statusId,
    "eventLink": eventLink,
    "eventLinkId": eventLinkId,
    "flyerLink2": flyerLink2,
    "flyerLink2Id": flyerLink2Id,
    "flyerLink3": flyerLink3,
    "flyerLink3Id": flyerLink3Id,
    "flyerName": flyerName,
    "flyerName2": flyerName2,
    "flyerName2Id": flyerName2Id,
    "flyerName3": flyerName3,
    "flyerName3Id": flyerName3Id,
    "flyerNameId": flyerNameId,
    "qrCode": qrCode,
    "qrCodeId": qrCodeId,
    "sequenceIdAsNumber": sequenceIdAsNumber,
  };

}
