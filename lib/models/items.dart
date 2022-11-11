import 'package:cloud_firestore/cloud_firestore.dart';

class Items {
  int? FullPrice;
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
  String? thumbnailUrl2;
  String? thumbnailUrl3;
  int? timesRented;
  String? title;
  String? itemType;
  String? type;

  Items({
    this.FullPrice,
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
    this.thumbnailUrl2,
    this.thumbnailUrl3,
    this.timesRented,
    this.title,
    this.type,
    this.itemType,
  });

  Items.fromJson(Map<String, dynamic> json) {
    FullPrice = json["FullPrice"];
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
    thumbnailUrl2 = json["thumbnailUrl2"];
    thumbnailUrl3 = json["thumbnailUrl3"];
    timesRented = json["timesRented"];
    title = json["title"];
    type = json["type"];
    itemType = json["itemType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["FullPrice"] = this.FullPrice;
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
    data["thumbnailUrl2"] = this.thumbnailUrl2;
    data["thumbnailUrl3"] = this.thumbnailUrl3;
    data["timesRented"] = this.timesRented;
    data["title"] = this.title;
    data["type"] = this.type;
    data["itemType"] = this.itemType;

    return data;
  }
}
