import 'package:cloud_firestore/cloud_firestore.dart';

class BookOrders {
  String? orderID;
  String? userName;
  int? userPhoneNumber;
  int? sellerPhoneNumber;
  String? orderStatus;
  String? receiver;
  String? giver;
  String? userWhat3Words;
  String? sellerWhat3Words;
  double? userLat;
  double? userLng;
  double? distanceBetween;

  BookOrders({
    this.orderID,
    this.userName,
    this.userPhoneNumber,
    this.sellerPhoneNumber,
    this.orderStatus,
    this.receiver,
    this.giver,
    this.userWhat3Words,
    this.sellerWhat3Words,
    this.userLat,
    this.userLng,
    this.distanceBetween,
  });

  BookOrders.fromJson(Map<String, dynamic> json) {
    orderID = json["orderID"];
    userName = json["userName"];
    userPhoneNumber = json["userPhoneNumber"];
    sellerPhoneNumber = json["sellerPhoneNumber"];
    orderStatus = json["orderStatus"];
    receiver = json["receiver"];
    giver = json["giver"];
    userWhat3Words = json["userWhat3Words"];
    sellerWhat3Words = json["sellerWhat3Words"];
    userLat = json["userLat"];
    userLng = json["userLng"];
    distanceBetween = json["distanceBetween"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["orderID"] = this.orderID;
    data["userName"] = this.userName;
    data["userPhoneNumber"] = this.userPhoneNumber;
    data["sellerPhoneNumber"] = this.sellerPhoneNumber;
    data["orderStatus"] = this.orderStatus;
    data["receiver"] = this.receiver;
    data["giver"] = this.giver;
    data["userWhat3Words"] = this.userWhat3Words;
    data["sellerWhat3Words"] = this.sellerWhat3Words;
    data["userLat"] = this.userLat;
    data["userLng"] = this.userLng;
    data["distanceBetween"] = this.distanceBetween;

    return data;
  }
}
