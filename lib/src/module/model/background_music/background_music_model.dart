class BackgroundMusicModel {
  BackgroundMusicModel({
    required this.statusCode,
    required this.message,
    required this.count,
    required this.data,
  });

  final String? statusCode;
  final String? message;
  final int? count;
  final List<Datum> data;

  factory BackgroundMusicModel.fromJson(Map<String, dynamic> json){
    return BackgroundMusicModel(
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
    required this.dayName,
    required this.musicName,
    required this.refDataName,
    required this.status,
    required this.sequenceId,
    required this.moduleName,
    required this.clientId,
    required this.productId,
    required this.aspectType,
    required this.recCreBy,
    required this.recCreDate,
    required this.recCreTime,
    required this.sequenceIdAsNumber,
  });

  final String? id;
  final String? dayName;
  final String? musicName;
  final String? refDataName;
  final String? status;
  final String? sequenceId;
  final String? moduleName;
  final String? clientId;
  final String? productId;
  final String? aspectType;
  final String? recCreBy;
  final String? recCreDate;
  final String? recCreTime;
  final int? sequenceIdAsNumber;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      dayName: json["dayName"],
      musicName: json["musicName"],
      refDataName: json["refDataName"],
      status: json["status"],
      sequenceId: json["sequenceId"],
      moduleName: json["moduleName"],
      clientId: json["clientID"],
      productId: json["productID"],
      aspectType: json["aspectType"],
      recCreBy: json["recCreBy"],
      recCreDate: json["recCreDate"],
      recCreTime: json["recCreTime"],
      sequenceIdAsNumber: json["sequenceIdAsNumber"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "dayName": dayName,
    "musicName": musicName,
    "refDataName": refDataName,
    "status": status,
    "sequenceId": sequenceId,
    "moduleName": moduleName,
    "clientID": clientId,
    "productID": productId,
    "aspectType": aspectType,
    "recCreBy": recCreBy,
    "recCreDate": recCreDate,
    "recCreTime": recCreTime,
    "sequenceIdAsNumber": sequenceIdAsNumber,
  };

}
