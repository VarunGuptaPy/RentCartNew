import 'package:cloud_firestore/cloud_firestore.dart';

class Subscription {
  String? LongDescription;
  int? SingleDayRent;
  int? SingleMonthRent;
  int? SingleWeekRent;
  String? itemID;
  Timestamp? publishedDate;
  String? sellerName;
  String? sellerUID;
  String? shortInfo;
  String? status;
  String? thumbnailUrl;
  int? timesRented;
  String? title;
  String? type;
  String? rentTillYear;
  String? itemType;
  String? rentTillMonth;
  String? rentTillDay;
  String? typeOfSubscription;

  Subscription({
    this.LongDescription,
    this.SingleDayRent,
    this.SingleMonthRent,
    this.SingleWeekRent,
    this.itemID,
    this.publishedDate,
    this.sellerName,
    this.sellerUID,
    this.shortInfo,
    this.status,
    this.thumbnailUrl,
    this.timesRented,
    this.title,
    this.itemType,
    this.type,
    this.rentTillYear,
    this.rentTillMonth,
    this.rentTillDay,
  });

  Subscription.fromJson(Map<String, dynamic> json) {
    LongDescription = json["LongDescription"];
    SingleDayRent = json["SingleDayRent"];
    SingleMonthRent = json["SingleMonthRent"];
    SingleWeekRent = json["SingleWeekRent"];
    itemID = json["itemID"];
    publishedDate = json["publishedDate"];
    sellerName = json["sellerName"];
    sellerUID = json["sellerUID"];
    shortInfo = json["shortInfo"];
    status = json["status"];
    thumbnailUrl = json["thumbnailUrl"];
    timesRented = json["timesRented"];
    title = json["title"];
    type = json["type"];
    itemType = json["itemType"];
    rentTillYear = json["rentTillYear"];
    rentTillMonth = json["rentTillMonth"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["LongDescription"] = this.LongDescription;
    data["SingleDayRent"] = this.SingleDayRent;
    data["SingleMonthRent"] = this.SingleMonthRent;
    data["SingleWeekRent"] = this.SingleWeekRent;
    data["itemID"] = this.itemID;
    data["publishedDate"] = this.publishedDate;
    data["sellerName"] = this.sellerName;
    data["sellerUID"] = this.sellerUID;
    data["shortInfo"] = this.shortInfo;
    data["status"] = this.status;
    data["thumbnailUrl"] = this.thumbnailUrl;
    data["timesRented"] = this.timesRented;
    data["title"] = this.title;
    data["type"] = this.type;
    data['itemType'] = this.itemType;
    data["rentTillYear"] = this.rentTillYear;
    data["rentTillMonth"] = this.rentTillMonth;
    data["rentTillDay"] = this.rentTillDay;

    return data;
  }
}
