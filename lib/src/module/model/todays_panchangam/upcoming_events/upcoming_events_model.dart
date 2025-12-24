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
    required this.image,
    required this.imageId,
    required this.serviceCategoryTypes,
    required this.serviceCategoryTypesId,
    required this.serviceTypes,
    required this.serviceTypesId,
    required this.eventDispay,
    required this.eventDispayId,
    required this.parentService,
    required this.parentServiceId,
    required this.refDataName,
    required this.refDataNameId,
    required this.serviceAmount,
    required this.serviceAmountId,
    required this.sourceTypes,
    required this.sourceTypesId,
    required this.phone,
    required this.phoneId,
    required this.poojalist,
    required this.poojalistId,
    required this.description,
    required this.descriptionId,
    required this.dayTypes,
    required this.dayTypesId,
    required this.qtyCounter,
    required this.qtyCounterId,
    required this.paymentType,
    required this.paymentTypeId,
    required this.venue,
    required this.venueId,
    required this.startDate,
    required this.startDateId,
    required this.endDate,
    required this.endDateId,
    required this.startTime,
    required this.startTimeId,
    required this.endTime,
    required this.endTimeId,
    required this.taxWriteoff,
    required this.taxWriteoffId,
    required this.status,
    required this.statusId,
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
    required this.availabilityInd,
    required this.availabilityIndId,
    required this.awayTempleAmount,
    required this.awayTempleAmountId,
    required this.bookingType,
    required this.bookingTypeId,
    required this.dietyName,
    required this.dietyNameId,
    required this.flyerLink,
    required this.flyerLink2,
    required this.flyerLink2Id,
    required this.flyerLink3,
    required this.flyerLink3Id,
    required this.flyerLinkId,
    required this.flyerName,
    required this.flyerName2,
    required this.flyerName2Id,
    required this.flyerName3,
    required this.flyerName3Id,
    required this.flyerNameId,
    required this.includeSankalpam,
    required this.includeSankalpamId,
    required this.isDtVisible,
    required this.isDtVisibleId,
    required this.isTextinputBox,
    required this.isTextinputBoxId,
    required this.overrideOption,
    required this.overrideOptionId,
    required this.servicesDispayGroup,
    required this.servicesDispayGroupId,
    required this.specialAmount,
    required this.specialAmountId,
    required this.weekendAmount,
    required this.weekendAmountId,
    required this.description2,
    required this.description2Id,
    required this.desc,
    required this.serviceDescription,
    required this.servicedisplaygroup,
    required this.servicedisplaygroupId,
    required this.sequenceIdAsNumber,
    required this.holdingDates,
    required this.holdingDatesId,
    required this.serviceOccurrencesNo,
    required this.serviceOccurrencesNoId,
    required this.multiImage,
    required this.multiImageId,
    required this.showAsCart,
    required this.showAsCartId,
    required this.isAvailable,
    required this.bookingLimitPerDay,
    required this.bookingLimitPerDayId,
    required this.isDietySelected,
    required this.isDietySelectedId,
    required this.isTimeVisible,
    required this.isTimeVisibleId,
    required this.refCore,
    required this.refCoreId,
    required this.availableCount,
  });

  final String? id;
  final String? image;
  final String? imageId;
  final String? serviceCategoryTypes;
  final String? serviceCategoryTypesId;
  final String? serviceTypes;
  final String? serviceTypesId;
  final String? eventDispay;
  final String? eventDispayId;
  final String? parentService;
  final String? parentServiceId;
  final String? refDataName;
  final String? refDataNameId;
  final dynamic? serviceAmount;
  final String? serviceAmountId;
  final String? sourceTypes;
  final String? sourceTypesId;
  final String? phone;
  final String? phoneId;
  final String? poojalist;
  final String? poojalistId;
  final String? description;
  final String? descriptionId;
  final String? dayTypes;
  final String? dayTypesId;
  final String? qtyCounter;
  final String? qtyCounterId;
  final String? paymentType;
  final String? paymentTypeId;
  final String? venue;
  final String? venueId;
  final String? startDate;
  final String? startDateId;
  final String? endDate;
  final String? endDateId;
  final String? startTime;
  final String? startTimeId;
  final String? endTime;
  final String? endTimeId;
  final String? taxWriteoff;
  final String? taxWriteoffId;
  final String? status;
  final String? statusId;
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
  final String? availabilityInd;
  final String? availabilityIndId;
  final String? awayTempleAmount;
  final String? awayTempleAmountId;
  final String? bookingType;
  final String? bookingTypeId;
  final String? dietyName;
  final String? dietyNameId;
  final String? flyerLink;
  final String? flyerLink2;
  final String? flyerLink2Id;
  final String? flyerLink3;
  final String? flyerLink3Id;
  final String? flyerLinkId;
  final String? flyerName;
  final String? flyerName2;
  final String? flyerName2Id;
  final String? flyerName3;
  final String? flyerName3Id;
  final String? flyerNameId;
  final String? includeSankalpam;
  final String? includeSankalpamId;
  final String? isDtVisible;
  final String? isDtVisibleId;
  final String? isTextinputBox;
  final String? isTextinputBoxId;
  final String? overrideOption;
  final String? overrideOptionId;
  final String? servicesDispayGroup;
  final String? servicesDispayGroupId;
  final String? specialAmount;
  final String? specialAmountId;
  final String? weekendAmount;
  final String? weekendAmountId;
  final String? description2;
  final String? description2Id;
  final String? desc;
  final String? serviceDescription;
  final String? servicedisplaygroup;
  final String? servicedisplaygroupId;
  final int? sequenceIdAsNumber;
  final String? holdingDates;
  final String? holdingDatesId;
  final String? serviceOccurrencesNo;
  final String? serviceOccurrencesNoId;
  final String? multiImage;
  final String? multiImageId;
  final String? showAsCart;
  final String? showAsCartId;
  final int? isAvailable;
  final String? bookingLimitPerDay;
  final String? bookingLimitPerDayId;
  final String? isDietySelected;
  final String? isDietySelectedId;
  final String? isTimeVisible;
  final String? isTimeVisibleId;
  final String? refCore;
  final String? refCoreId;
  final int? availableCount;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      image: json["Image"],
      imageId: json["ImageId"],
      serviceCategoryTypes: json["serviceCategoryTypes"],
      serviceCategoryTypesId: json["serviceCategoryTypesId"],
      serviceTypes: json["serviceTypes"],
      serviceTypesId: json["serviceTypesId"],
      eventDispay: json["EventDispay"],
      eventDispayId: json["EventDispayId"],
      parentService: json["parentService"],
      parentServiceId: json["parentServiceId"],
      refDataName: json["refDataName"],
      refDataNameId: json["refDataNameId"],
      serviceAmount: json["serviceAmount"],
      serviceAmountId: json["serviceAmountId"],
      sourceTypes: json["sourceTypes"],
      sourceTypesId: json["sourceTypesId"],
      phone: json["phone"],
      phoneId: json["phoneId"],
      poojalist: json["poojalist"],
      poojalistId: json["poojalistId"],
      description: json["description"],
      descriptionId: json["descriptionId"],
      dayTypes: json["dayTypes"],
      dayTypesId: json["dayTypesId"],
      qtyCounter: json["qtyCounter"],
      qtyCounterId: json["qtyCounterId"],
      paymentType: json["paymentType"],
      paymentTypeId: json["paymentTypeId"],
      venue: json["venue"],
      venueId: json["venueId"],
      startDate: json["startDate"],
      startDateId: json["startDateId"],
      endDate: json["endDate"],
      endDateId: json["endDateId"],
      startTime: json["startTime"],
      startTimeId: json["startTimeId"],
      endTime: json["endTime"],
      endTimeId: json["endTimeId"],
      taxWriteoff: json["taxWriteoff"],
      taxWriteoffId: json["taxWriteoffId"],
      status: json["status"],
      statusId: json["statusId"],
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
      availabilityInd: json["availabilityInd"],
      availabilityIndId: json["availabilityIndId"],
      awayTempleAmount: json["awayTempleAmount"],
      awayTempleAmountId: json["awayTempleAmountId"],
      bookingType: json["bookingType"],
      bookingTypeId: json["bookingTypeId"],
      dietyName: json["dietyName"],
      dietyNameId: json["dietyNameId"],
      flyerLink: json["flyerLink"],
      flyerLink2: json["flyerLink2"],
      flyerLink2Id: json["flyerLink2Id"],
      flyerLink3: json["flyerLink3"],
      flyerLink3Id: json["flyerLink3Id"],
      flyerLinkId: json["flyerLinkId"],
      flyerName: json["flyerName"],
      flyerName2: json["flyerName2"],
      flyerName2Id: json["flyerName2Id"],
      flyerName3: json["flyerName3"],
      flyerName3Id: json["flyerName3Id"],
      flyerNameId: json["flyerNameId"],
      includeSankalpam: json["includeSankalpam"],
      includeSankalpamId: json["includeSankalpamId"],
      isDtVisible: json["isDTVisible"],
      isDtVisibleId: json["isDTVisibleId"],
      isTextinputBox: json["isTextinputBox"],
      isTextinputBoxId: json["isTextinputBoxId"],
      overrideOption: json["overrideOption"],
      overrideOptionId: json["overrideOptionId"],
      servicesDispayGroup: json["servicesDispayGroup"],
      servicesDispayGroupId: json["servicesDispayGroupId"],
      specialAmount: json["specialAmount"],
      specialAmountId: json["specialAmountId"],
      weekendAmount: json["weekendAmount"],
      weekendAmountId: json["weekendAmountId"],
      description2: json["description2"],
      description2Id: json["description2Id"],
      desc: json["desc"],
      serviceDescription: json["serviceDescription"],
      servicedisplaygroup: json["servicedisplaygroup"],
      servicedisplaygroupId: json["servicedisplaygroupId"],
      sequenceIdAsNumber: json["sequenceIdAsNumber"],
      holdingDates: json["holdingDates"],
      holdingDatesId: json["holdingDatesId"],
      serviceOccurrencesNo: json["serviceOccurrencesNo"],
      serviceOccurrencesNoId: json["serviceOccurrencesNoId"],
      multiImage: json["multiImage"],
      multiImageId: json["multiImageId"],
      showAsCart: json["showAsCart"],
      showAsCartId: json["showAsCartId"],
      isAvailable: json["isAvailable"],
      bookingLimitPerDay: json["BookingLimitPerDay"],
      bookingLimitPerDayId: json["BookingLimitPerDayId"],
      isDietySelected: json["isDietySelected"],
      isDietySelectedId: json["isDietySelectedId"],
      isTimeVisible: json["isTimeVisible"],
      isTimeVisibleId: json["isTimeVisibleId"],
      refCore: json["refCore"],
      refCoreId: json["refCoreId"],
      availableCount: json["AvailableCount"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Image": image,
    "ImageId": imageId,
    "serviceCategoryTypes": serviceCategoryTypes,
    "serviceCategoryTypesId": serviceCategoryTypesId,
    "serviceTypes": serviceTypes,
    "serviceTypesId": serviceTypesId,
    "EventDispay": eventDispay,
    "EventDispayId": eventDispayId,
    "parentService": parentService,
    "parentServiceId": parentServiceId,
    "refDataName": refDataName,
    "refDataNameId": refDataNameId,
    "serviceAmount": serviceAmount,
    "serviceAmountId": serviceAmountId,
    "sourceTypes": sourceTypes,
    "sourceTypesId": sourceTypesId,
    "phone": phone,
    "phoneId": phoneId,
    "poojalist": poojalist,
    "poojalistId": poojalistId,
    "description": description,
    "descriptionId": descriptionId,
    "dayTypes": dayTypes,
    "dayTypesId": dayTypesId,
    "qtyCounter": qtyCounter,
    "qtyCounterId": qtyCounterId,
    "paymentType": paymentType,
    "paymentTypeId": paymentTypeId,
    "venue": venue,
    "venueId": venueId,
    "startDate": startDate,
    "startDateId": startDateId,
    "endDate": endDate,
    "endDateId": endDateId,
    "startTime": startTime,
    "startTimeId": startTimeId,
    "endTime": endTime,
    "endTimeId": endTimeId,
    "taxWriteoff": taxWriteoff,
    "taxWriteoffId": taxWriteoffId,
    "status": status,
    "statusId": statusId,
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
    "availabilityInd": availabilityInd,
    "availabilityIndId": availabilityIndId,
    "awayTempleAmount": awayTempleAmount,
    "awayTempleAmountId": awayTempleAmountId,
    "bookingType": bookingType,
    "bookingTypeId": bookingTypeId,
    "dietyName": dietyName,
    "dietyNameId": dietyNameId,
    "flyerLink": flyerLink,
    "flyerLink2": flyerLink2,
    "flyerLink2Id": flyerLink2Id,
    "flyerLink3": flyerLink3,
    "flyerLink3Id": flyerLink3Id,
    "flyerLinkId": flyerLinkId,
    "flyerName": flyerName,
    "flyerName2": flyerName2,
    "flyerName2Id": flyerName2Id,
    "flyerName3": flyerName3,
    "flyerName3Id": flyerName3Id,
    "flyerNameId": flyerNameId,
    "includeSankalpam": includeSankalpam,
    "includeSankalpamId": includeSankalpamId,
    "isDTVisible": isDtVisible,
    "isDTVisibleId": isDtVisibleId,
    "isTextinputBox": isTextinputBox,
    "isTextinputBoxId": isTextinputBoxId,
    "overrideOption": overrideOption,
    "overrideOptionId": overrideOptionId,
    "servicesDispayGroup": servicesDispayGroup,
    "servicesDispayGroupId": servicesDispayGroupId,
    "specialAmount": specialAmount,
    "specialAmountId": specialAmountId,
    "weekendAmount": weekendAmount,
    "weekendAmountId": weekendAmountId,
    "description2": description2,
    "description2Id": description2Id,
    "desc": desc,
    "serviceDescription": serviceDescription,
    "servicedisplaygroup": servicedisplaygroup,
    "servicedisplaygroupId": servicedisplaygroupId,
    "sequenceIdAsNumber": sequenceIdAsNumber,
    "holdingDates": holdingDates,
    "holdingDatesId": holdingDatesId,
    "serviceOccurrencesNo": serviceOccurrencesNo,
    "serviceOccurrencesNoId": serviceOccurrencesNoId,
    "multiImage": multiImage,
    "multiImageId": multiImageId,
    "showAsCart": showAsCart,
    "showAsCartId": showAsCartId,
    "isAvailable": isAvailable,
    "BookingLimitPerDay": bookingLimitPerDay,
    "BookingLimitPerDayId": bookingLimitPerDayId,
    "isDietySelected": isDietySelected,
    "isDietySelectedId": isDietySelectedId,
    "isTimeVisible": isTimeVisible,
    "isTimeVisibleId": isTimeVisibleId,
    "refCore": refCore,
    "refCoreId": refCoreId,
    "AvailableCount": availableCount,
  };

}
