// To parse this JSON data, do
//
//     final ratingReviewsResponse = ratingReviewsResponseFromJson(jsonString);

import 'dart:convert';

RatingReviewsResponse ratingReviewsResponseFromJson(String str) => RatingReviewsResponse.fromJson(json.decode(str));

String ratingReviewsResponseToJson(RatingReviewsResponse data) => json.encode(data.toJson());

class RatingReviewsResponse {
  String? message;
  bool? status;
  List<RatingReviews>? data;

  RatingReviewsResponse({
    this.message,
    this.status,
    this.data,
  });

  factory RatingReviewsResponse.fromJson(Map<String, dynamic> json) => RatingReviewsResponse(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? [] : List<RatingReviews>.from(json["data"]!.map((x) => RatingReviews.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class RatingReviews {
  String? id;
  String? productId;
  double? totalRatings;
  int? totalReview;
  double? ratings;
  List<AllReview>? allReview;

  RatingReviews({
    this.id,
    this.productId,
    this.totalRatings,
    this.totalReview,
    this.ratings,
    this.allReview,
  });

  factory RatingReviews.fromJson(Map<String, dynamic> json) => RatingReviews(
    id: json["_id"],
    productId: json["productId"],
    totalRatings: json["totalRatings"]?.toDouble(),
    totalReview: json["totalReview"],
    ratings: json["ratings"]?.toDouble(),
    allReview: json["AllReview"] == null ? [] : List<AllReview>.from(json["AllReview"]!.map((x) => AllReview.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productId": productId,
    "totalRatings": totalRatings,
    "totalReview": totalReview,
    "ratings": ratings,
    "AllReview": allReview == null ? [] : List<dynamic>.from(allReview!.map((x) => x.toJson())),
  };
}

class AllReview {
  String? id;
  String? userId;
  String? userName;
  String? userDescription;
  String? profileImage;
  int? userRating;

  AllReview({
    this.id,
    this.userId,
    this.userName,
    this.userDescription,
    this.profileImage,
    this.userRating,
  });

  factory AllReview.fromJson(Map<String, dynamic> json) => AllReview(
    id: json["_id"],
    userId: json["userId"],
    userName: json["userName"],
    userDescription: json["userDescription"],
    profileImage: json["profileImage"],
    userRating: json["userRating"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "userName": userName,
    "userDescription": userDescription,
    "profileImage": profileImage,
    "userRating": userRating,
  };
}
