import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionOrder {
  String? orderID;
  Timestamp? OrderPlacedAt;
  Timestamp? OrderEnd;
  String? sellerUID;
  String? userUID;
  String? ItemUID;
  String? itemImage;
  String? itemTitle;
  String? itemShortDescription;
  int? totalAmount;
  String? status;

  SubscriptionOrder({
    this.orderID,
    this.OrderPlacedAt,
    this.OrderEnd,
    this.sellerUID,
    this.userUID,
    this.ItemUID,
    this.itemImage,
    this.itemShortDescription,
    this.itemTitle,
    this.totalAmount,
  });

  SubscriptionOrder.fromJson(Map<String, dynamic> json) {
    orderID = json["orderID"];
    OrderPlacedAt = json["OrderPlacedAt"];
    OrderEnd = json["OrderEnd"];
    sellerUID = json["sellerUID"];
    userUID = json["userUID"];
    ItemUID = json["ItemUID"];
    itemImage = json["itemImage"];
    itemTitle = json["itemTitle"];
    itemShortDescription = json["itemShortDescription"];
    totalAmount = json["totalAmount"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["orderID"] = this.orderID;
    data["OrderPlacedAt"] = this.OrderPlacedAt;
    data["OrderEnd"] = this.OrderEnd;
    data["sellerUID"] = this.sellerUID;
    data["userUID"] = this.userUID;
    data["ItemUID"] = this.ItemUID;
    data["itemImage"] = this.itemImage;
    data["itemTitle"] = this.itemTitle;
    data["itemShortDescription"] = this.itemShortDescription;
    data["totalAmount"] = this.totalAmount;
    data["status"] = this.status;

    return data;
  }
}
