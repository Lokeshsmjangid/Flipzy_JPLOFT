// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'dart:convert';

CouponModel couponModelFromJson(String str) => CouponModel.fromJson(json.decode(str));

String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
  bool? success;
  List<Coupon>? data;

  CouponModel({
    this.success,
    this.data,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<Coupon>.from(json["data"]!.map((x) => Coupon.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Coupon {
  String? id;
  String? title;
  String? promoCode;
  String? discountType;
  int? discount;
  DateTime? startDate;
  DateTime? endDate;
  String? shortDescription;
  bool? isActive;
  DateTime? createdAt;
  int? v;
  bool actionText;

  Coupon({
    this.id,
    this.title,
    this.promoCode,
    this.discountType,
    this.discount,
    this.startDate,
    this.endDate,
    this.shortDescription,
    this.isActive,
    this.createdAt,
    this.v,
    this.actionText = false,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    id: json["_id"],
    title: json["title"],
    promoCode: json["promoCode"],
    discountType: json["discountType"],
    discount: json["discount"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    shortDescription: json["shortDescription"],
    isActive: json["isActive"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "promoCode": promoCode,
    "discountType": discountType,
    "discount": discount,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "shortDescription": shortDescription,
    "isActive": isActive,
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
  };
}
