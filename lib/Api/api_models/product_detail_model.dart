// To parse this JSON data, do
//
//     final productDetailResponse = productDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'home_model_response.dart';

ProductDetailResponse productDetailResponseFromJson(String str) => ProductDetailResponse.fromJson(json.decode(str));

String productDetailResponseToJson(ProductDetailResponse data) => json.encode(data.toJson());

class ProductDetailResponse {
  String? message;
  bool? status;
  Data? data;

  ProductDetailResponse({
    this.message,
    this.status,
    this.data,
  });

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) => ProductDetailResponse(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  String? sellerImage;
  String? sellerName;
  String? sellerRating;
  Product? productList;

  Data({
    this.sellerImage,
    this.sellerName,
    this.sellerRating,
    this.productList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sellerImage: json["sellerImage"],
    sellerName: json["sellerName"],
    sellerRating: json["sellerRating"],
    productList: json["productList"] == null ? null : Product.fromJson(json["productList"]),
  );

  Map<String, dynamic> toJson() => {
    "sellerImage": sellerImage,
    "sellerName": sellerName,
    "sellerRating": sellerRating,
    "productList": productList?.toJson(),
  };
}
