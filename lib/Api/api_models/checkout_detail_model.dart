// To parse this JSON data, do
//
//     final checkOutDetailModel = checkOutDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:flipzy/Api/api_models/address_response_model.dart';

import 'home_model_response.dart';

CheckOutDetailModel checkOutDetailModelFromJson(String str) => CheckOutDetailModel.fromJson(json.decode(str));

String checkOutDetailModelToJson(CheckOutDetailModel data) => json.encode(data.toJson());

class CheckOutDetailModel {
  bool? success;
  String? message;
  CheckOutData? data;

  CheckOutDetailModel({
    this.success,
    this.message,
    this.data,
  });

  factory CheckOutDetailModel.fromJson(Map<String, dynamic> json) => CheckOutDetailModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : CheckOutData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class CheckOutData {
  Product? product;
  AddressModel? shippingAddress;
  dynamic productPrice;
  dynamic shippingCharge;
  dynamic originalTotal;
  dynamic discount;
  dynamic totalAmount;
  AppliedCoupon? appliedCoupon;
  dynamic sellerAddress;
  bool? isDelivered;

  CheckOutData({
    this.product,
    this.shippingAddress,
    this.productPrice,
    this.shippingCharge,
    this.originalTotal,
    this.discount,
    this.totalAmount,
    this.appliedCoupon,
    this.sellerAddress,
    this.isDelivered,

  });

  factory CheckOutData.fromJson(Map<String, dynamic> json) => CheckOutData(
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    shippingAddress: json["shippingAddress"] == null ? null : AddressModel.fromJson(json["shippingAddress"]),
    productPrice: json["productPrice"],
    shippingCharge: json["shippingCharge"],
    originalTotal: json["originalTotal"],
    discount: json["discount"],
    totalAmount: json["totalAmount"],
    appliedCoupon: json["appliedCoupon"] == null ? null : AppliedCoupon.fromJson(json["appliedCoupon"]),
    sellerAddress: json["sellerAddress"],
    isDelivered: json["isDelivered"],
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "shippingAddress": shippingAddress?.toJson(),
    "productPrice": productPrice,
    "shippingCharge": shippingCharge,
    "originalTotal": originalTotal,
    "discount": discount,
    "totalAmount": totalAmount,
    "appliedCoupon": appliedCoupon?.toJson(),
    "sellerAddress": sellerAddress,
    "isDelivered": isDelivered,
  };
}

class AppliedCoupon {
  String? promoCode;
  String? discountType;
  int? discountValue;

  AppliedCoupon({
    this.promoCode,
    this.discountType,
    this.discountValue,
  });

  factory AppliedCoupon.fromJson(Map<String, dynamic> json) => AppliedCoupon(
    promoCode: json["promoCode"],
    discountType: json["discountType"],
    discountValue: json["discountValue"],
  );

  Map<String, dynamic> toJson() => {
    "promoCode": promoCode,
    "discountType": discountType,
    "discountValue": discountValue,
  };
}
