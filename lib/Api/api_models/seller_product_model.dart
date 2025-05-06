// To parse this JSON data, do
//
//     final sellerProductsModelResponse = sellerProductsModelResponseFromJson(jsonString);

import 'dart:convert';

import 'home_model_response.dart';

SellerProductsModelResponse sellerProductsModelResponseFromJson(String str) => SellerProductsModelResponse.fromJson(json.decode(str));

String sellerProductsModelResponseToJson(SellerProductsModelResponse data) => json.encode(data.toJson());

class SellerProductsModelResponse {
  String? message;
  bool? status;
  Data? data;

  SellerProductsModelResponse({
    this.message,
    this.status,
    this.data,
  });

  factory SellerProductsModelResponse.fromJson(Map<String, dynamic> json) => SellerProductsModelResponse(
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
  String? sellerRating;
  String? sellerProfileImage;
  String? sellerName;
  String? sellerLocation;
  int? totalProducts;
  int? page;
  int? limit;
  List<Product>? listProducts;

  Data({
    this.sellerRating,
    this.sellerProfileImage,
    this.sellerName,
    this.sellerLocation,
    this.totalProducts,
    this.page,
    this.limit,
    this.listProducts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sellerRating: json["sellerRating"],
    sellerProfileImage: json["sellerProfileImage"],
    sellerName: json["sellerName"],
    sellerLocation: json["sellerLocation"],
    totalProducts: json["totalProducts"],
    page: json["page"],
    limit: json["limit"],
    listProducts: json["listProducts"] == null ? [] : List<Product>.from(json["listProducts"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sellerRating": sellerRating,
    "sellerProfileImage": sellerProfileImage,
    "sellerName": sellerName,
    "sellerLocation": sellerLocation,
    "totalProducts": totalProducts,
    "page": page,
    "limit": limit,
    "listProducts": listProducts == null ? [] : List<dynamic>.from(listProducts!.map((x) => x.toJson())),
  };
}
