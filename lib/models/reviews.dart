import 'package:cloud_firestore/cloud_firestore.dart';

class Reviews {
  String? review;
  String? reviewUser;
  String? reviewUserImage;
  String? reviewUserName;

  Reviews({
    this.review,
    this.reviewUser,
    this.reviewUserImage,
    this.reviewUserName,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    review = json["review"];
    reviewUser = json["reviewUser"];
    reviewUserImage = json["reviewUserImage"];
    reviewUserName = json["reviewUserName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["review"] = this.review;
    data["reviewUser"] = this.reviewUser;
    data["reviewUserImage"] = this.reviewUserImage;
    data["reviewUserName"] = this.reviewUserImage;

    return data;
  }
}
