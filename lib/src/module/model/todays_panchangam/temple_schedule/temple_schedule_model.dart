class TempleScheduleModel {
  TempleScheduleModel({
    required this.statusCode,
    required this.message,
    required this.count,
    required this.data,
  });

  final String? statusCode;
  final String? message;
  final int? count;
  final List<Datum> data;

  factory TempleScheduleModel.fromJson(Map<String, dynamic> json){
    return TempleScheduleModel(
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
    required this.scheduleType,
    required this.scheduleTypeId,
    required this.image,
    required this.imageId,
    required this.refDataName,
    required this.refDataNameId,
    required this.linkUrl,
    required this.linkUrlId,
    required this.sequenceId,
    required this.sequenceIdId,
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
    required this.timing,
    required this.timingId,
    required this.comment,
    required this.commentId,
    required this.date,
    required this.dateId,
    required this.status,
    required this.statusId,
    required this.sequenceIdAsNumber,
  });

  final String? id;
  final String? scheduleType;
  final String? scheduleTypeId;
  final String? image;
  final String? imageId;
  final String? refDataName;
  final String? refDataNameId;
  final String? linkUrl;
  final String? linkUrlId;
  final String? sequenceId;
  final String? sequenceIdId;
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
  final String? timing;
  final String? timingId;
  final String? comment;
  final String? commentId;
  final String? date;
  final String? dateId;
  final String? status;
  final String? statusId;
  final int? sequenceIdAsNumber;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      scheduleType: json["scheduleType"],
      scheduleTypeId: json["scheduleTypeId"],
      image: json["image"],
      imageId: json["imageId"],
      refDataName: json["refDataName"],
      refDataNameId: json["refDataNameId"],
      linkUrl: json["linkUrl"],
      linkUrlId: json["linkUrlId"],
      sequenceId: json["sequenceId"],
      sequenceIdId: json["sequenceIdId"],
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
      timing: json["timing"],
      timingId: json["timingId"],
      comment: json["comment"],
      commentId: json["commentId"],
      date: json["date"],
      dateId: json["dateId"],
      status: json["status"],
      statusId: json["statusId"],
      sequenceIdAsNumber: json["sequenceIdAsNumber"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "scheduleType": scheduleType,
    "scheduleTypeId": scheduleTypeId,
    "image": image,
    "imageId": imageId,
    "refDataName": refDataName,
    "refDataNameId": refDataNameId,
    "linkUrl": linkUrl,
    "linkUrlId": linkUrlId,
    "sequenceId": sequenceId,
    "sequenceIdId": sequenceIdId,
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
    "timing": timing,
    "timingId": timingId,
    "comment": comment,
    "commentId": commentId,
    "date": date,
    "dateId": dateId,
    "status": status,
    "statusId": statusId,
    "sequenceIdAsNumber": sequenceIdAsNumber,
  };

}
