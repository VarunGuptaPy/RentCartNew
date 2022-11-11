import 'package:cloud_firestore/cloud_firestore.dart';

class UserSubscription {
  String? itemId;
  String? sellerUID;
  String? sellerName;
  String? shortInfo;
  String? LongDescription;
  int? SingleDayRent;
  int? SingleWeekRent;
  int? SingleMonthRent;
  String? title;
  String? publishedDate;
  String? rentTillYear;
  String? rentTillMonth;
  String? rentTillDay;
  String? subscriptionEmail;
  int? timesRented;
  String? thumbnailUrl;
  String? type;
  String? status;
  String? typeOfSubscription;
  String? password;

  UserSubscription({
    this.itemId,
    this.sellerUID,
    this.sellerName,
    this.shortInfo,
    this.LongDescription,
    this.SingleDayRent,
    this.SingleWeekRent,
    this.SingleMonthRent,
    this.title,
    this.publishedDate,
    this.rentTillYear,
    this.rentTillMonth,
    this.rentTillDay,
    this.subscriptionEmail,
    this.timesRented,
    this.thumbnailUrl,
    this.type,
    this.status,
    this.typeOfSubscription,
    this.password,
  });

  UserSubscription.fromJson(Map<String, dynamic> json) {
    itemId = json["itemID"];
    sellerUID = json["sellerUID"];
    sellerName = json["sellerName"];
    shortInfo = json["shortInfo"];
    LongDescription = json["LongDescription"];
    SingleDayRent = json["SingleDayRent"];
    SingleWeekRent = json["SingleWeekRent"];
    SingleMonthRent = json["SingleMonthRent"];
    title = json["title"];
    publishedDate = json["publishedDate"];
    rentTillYear = json["rentTillYear"];
    rentTillMonth = json["rentTillMonth"];
    rentTillDay = json["rentTillDay"];
    subscriptionEmail = json["subscriptionEmail"];
    timesRented = json["timesRented"];
    thumbnailUrl = json["thumbnailUrl"];
    type = json["type"];
    status = json["status"];
    typeOfSubscription = json["itemType"];
    password = json["password"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["LongDescription"] = this.LongDescription;
    data["SingleDayRent"] = this.SingleDayRent;
    data["SingleWeekRent"] = this.SingleWeekRent;
    data["SingleMonthRent"] = this.SingleMonthRent;
    data["itemID"] = this.itemId;
    data["itemType"] = this.typeOfSubscription;
    data["sellerUID"] = this.sellerUID;
    data["sellerName"] = this.sellerName;
    data["shortInfo"] = this.shortInfo;
    data["title"] = this.title;
    data["publishedDate"] = this.publishedDate;
    data["rentTillYear"] = this.rentTillYear;
    data["rentTillMonth"] = this.rentTillMonth;
    data["rentTillDay"] = this.rentTillDay;
    data["subscriptionEmail"] = this.subscriptionEmail;
    data["timesRented"] = this.timesRented;
    data["thumbnailUrl"] = this.thumbnailUrl;
    data["type"] = this.type;
    data["status"] = this.status;
    data["password"] = this.password;
    return data;
  }
}
