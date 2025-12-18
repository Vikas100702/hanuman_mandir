class HeaderModel {
  HeaderModel({
    required this.statusCode,
    required this.message,
    required this.count,
    required this.data,
  });

  final String? statusCode;
  final String? message;
  final int? count;
  final List<Datum> data;

  factory HeaderModel.fromJson(Map<String, dynamic> json){
    return HeaderModel(
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
    required this.sequenceId,
    required this.refDataName,
    required this.subHeading,
    required this.leftImage,
    required this.rightImage,
    required this.address,
    required this.templeTiming,
    required this.moduleName,
    required this.clientId,
    required this.productId,
    required this.aspectType,
    required this.recCreBy,
    required this.recCreDate,
    required this.recModBy,
    required this.recModDate,
    required this.recModTime,
    required this.email,
    required this.phone,
    required this.subHeading2,
    required this.subHeading3,
    required this.subHeading4,
    required this.taxId,
    required this.phoneNo,
    required this.addressId,
    required this.emailId,
    required this.leftImageId,
    required this.phoneId,
    required this.phoneNoId,
    required this.refDataNameId,
    required this.rightImageId,
    required this.subHeading2Id,
    required this.subHeading3Id,
    required this.subHeading4Id,
    required this.subHeadingId,
    required this.taxIdId,
    required this.templeTimingId,
    required this.sequenceIdAsNumber,
  });

  final String? id;
  final String? sequenceId;
  final String? refDataName;
  final String? subHeading;
  final String? leftImage;
  final String? rightImage;
  final String? address;
  final String? templeTiming;
  final String? moduleName;
  final String? clientId;
  final String? productId;
  final String? aspectType;
  final String? recCreBy;
  final String? recCreDate;
  final String? recModBy;
  final String? recModDate;
  final int? recModTime;
  final String? email;
  final String? phone;
  final String? subHeading2;
  final String? subHeading3;
  final String? subHeading4;
  final String? taxId;
  final String? phoneNo;
  final String? addressId;
  final String? emailId;
  final String? leftImageId;
  final String? phoneId;
  final String? phoneNoId;
  final String? refDataNameId;
  final String? rightImageId;
  final String? subHeading2Id;
  final String? subHeading3Id;
  final String? subHeading4Id;
  final String? subHeadingId;
  final String? taxIdId;
  final String? templeTimingId;
  final int? sequenceIdAsNumber;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      sequenceId: json["sequenceId"],
      refDataName: json["refDataName"],
      subHeading: json["subHeading"],
      leftImage: json["leftImage"],
      rightImage: json["rightImage"],
      address: json["address"],
      templeTiming: json["templeTiming"],
      moduleName: json["moduleName"],
      clientId: json["clientID"],
      productId: json["productID"],
      aspectType: json["aspectType"],
      recCreBy: json["recCreBy"],
      recCreDate: json["recCreDate"],
      recModBy: json["recModBy"],
      recModDate: json["recModDate"],
      recModTime: json["recModTime"],
      email: json["email"],
      phone: json["phone"],
      subHeading2: json["subHeading2"],
      subHeading3: json["subHeading3"],
      subHeading4: json["subHeading4"],
      taxId: json["taxId"],
      phoneNo: json["phoneNo"],
      addressId: json["addressId"],
      emailId: json["emailId"],
      leftImageId: json["leftImageId"],
      phoneId: json["phoneId"],
      phoneNoId: json["phoneNoId"],
      refDataNameId: json["refDataNameId"],
      rightImageId: json["rightImageId"],
      subHeading2Id: json["subHeading2Id"],
      subHeading3Id: json["subHeading3Id"],
      subHeading4Id: json["subHeading4Id"],
      subHeadingId: json["subHeadingId"],
      taxIdId: json["taxIdId"],
      templeTimingId: json["templeTimingId"],
      sequenceIdAsNumber: json["sequenceIdAsNumber"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sequenceId": sequenceId,
    "refDataName": refDataName,
    "subHeading": subHeading,
    "leftImage": leftImage,
    "rightImage": rightImage,
    "address": address,
    "templeTiming": templeTiming,
    "moduleName": moduleName,
    "clientID": clientId,
    "productID": productId,
    "aspectType": aspectType,
    "recCreBy": recCreBy,
    "recCreDate": recCreDate,
    "recModBy": recModBy,
    "recModDate": recModDate,
    "recModTime": recModTime,
    "email": email,
    "phone": phone,
    "subHeading2": subHeading2,
    "subHeading3": subHeading3,
    "subHeading4": subHeading4,
    "taxId": taxId,
    "phoneNo": phoneNo,
    "addressId": addressId,
    "emailId": emailId,
    "leftImageId": leftImageId,
    "phoneId": phoneId,
    "phoneNoId": phoneNoId,
    "refDataNameId": refDataNameId,
    "rightImageId": rightImageId,
    "subHeading2Id": subHeading2Id,
    "subHeading3Id": subHeading3Id,
    "subHeading4Id": subHeading4Id,
    "subHeadingId": subHeadingId,
    "taxIdId": taxIdId,
    "templeTimingId": templeTimingId,
    "sequenceIdAsNumber": sequenceIdAsNumber,
  };

}