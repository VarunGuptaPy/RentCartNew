import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  String? addressUID;
  String? city;
  String? country;
  String? fullAddress;
  String? name;
  String? phoneNumber;
  String? what3word;
  double? lat;
  double? lng;

  Address({
    this.addressUID,
    this.city,
    this.country,
    this.fullAddress,
    this.name,
    this.phoneNumber,
    this.what3word,
    this.lat,
    this.lng,
  });

  Address.fromJson(Map<String, dynamic> json) {
    addressUID = json["addressUID"];
    city = json["city"];
    country = json["country"];
    fullAddress = json["fullAddress"];
    name = json["name"];
    phoneNumber = json["phoneNumber"];
    what3word = json["what3word"];
    lat = json["lat"];
    lng = json["lng"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["addressUID"] = this.addressUID;
    data["city"] = this.city;
    data["country"] = this.country;
    data["fullAddress"] = this.fullAddress;
    data["name"] = this.name;
    data["phoneNumber"] = this.phoneNumber;
    data["what3word"] = this.what3word;
    data["lat"] = this.lat;
    data["lng"] = this.lng;

    return data;
  }
}