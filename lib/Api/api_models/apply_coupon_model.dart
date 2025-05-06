// To parse this JSON data, do
//
//     final applyCouponModel = applyCouponModelFromJson(jsonString);

import 'dart:convert';

import 'package:flipzy/Api/api_models/coupon_model.dart';

ApplyCouponModel applyCouponModelFromJson(String str) => ApplyCouponModel.fromJson(json.decode(str));

String applyCouponModelToJson(ApplyCouponModel data) => json.encode(data.toJson());

class ApplyCouponModel {
  bool? success;
  String? message;
  Coupon? data;

  ApplyCouponModel({
    this.success,
    this.message,
    this.data,
  });

  factory ApplyCouponModel.fromJson(Map<String, dynamic> json) => ApplyCouponModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Coupon.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}
