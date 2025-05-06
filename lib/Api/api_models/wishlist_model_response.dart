// To parse this JSON data, do
//
//     final wishlistModelResponse = wishlistModelResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flipzy/Api/api_models/home_model_response.dart';

WishlistModelResponse wishlistModelResponseFromJson(String str) => WishlistModelResponse.fromJson(json.decode(str));

String wishlistModelResponseToJson(WishlistModelResponse data) => json.encode(data.toJson());

class WishlistModelResponse {
  String? message;
  bool? status;
  List<Product>? wishlist;

  WishlistModelResponse({
    this.message,
    this.status,
    this.wishlist,
  });

  factory WishlistModelResponse.fromJson(Map<String, dynamic> json) => WishlistModelResponse(
    message: json["message"],
    status: json["status"],
    wishlist: json["data"] == null ? [] : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": wishlist == null ? [] : List<dynamic>.from(wishlist!.map((x) => x.toJson())),
  };
}

class Wishlist {
  String? id;
  String? userId;
  String? productId;
  String? image;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  Product? productDetails;

  Wishlist({
    this.id,
    this.userId,
    this.productId,
    this.image,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.productDetails,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
    id: json["_id"],
    userId: json["userId"],
    productId: json["productId"],
    image: json["image"],
    name: json["name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    productDetails: json["productDetails"] == null ? null : Product.fromJson(json["productDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "productId": productId,
    "image": image,
    "name": name,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "productDetails": productDetails?.toJson(),
  };
}
