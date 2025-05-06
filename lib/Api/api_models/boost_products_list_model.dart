// To parse this JSON data, do
//
//     final boostProductsModelResponse = boostProductsModelResponseFromJson(jsonString);

import 'dart:convert';

import 'home_model_response.dart';

BoostProductsModelResponse boostProductsModelResponseFromJson(String str) => BoostProductsModelResponse.fromJson(json.decode(str));

String boostProductsModelResponseToJson(BoostProductsModelResponse data) => json.encode(data.toJson());

class BoostProductsModelResponse {
  String? message;
  bool? status;
  Data? data;

  BoostProductsModelResponse({
    this.message,
    this.status,
    this.data,
  });

  factory BoostProductsModelResponse.fromJson(Map<String, dynamic> json) => BoostProductsModelResponse(
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
  int? boostProducts;
  int? activeProducts;
  int? totalProducts;
  ProductsList? productsList;

  Data({
    this.boostProducts,
    this.activeProducts,
    this.totalProducts,
    this.productsList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    boostProducts: json["boostProducts"],
    activeProducts: json["activeProducts"],
    totalProducts: json["totalProducts"],
    productsList: json["ProductsList"] == null ? null : ProductsList.fromJson(json["ProductsList"]),
  );

  Map<String, dynamic> toJson() => {
    "boostProducts": boostProducts,
    "activeProducts": activeProducts,
    "totalProducts": totalProducts,
    "ProductsList": productsList?.toJson(),
  };
}

class ProductsList {
  List<Product>? activeProducts;
  List<Product>? boostProducts;
  List<Product>? totalProducts;

  ProductsList({
    this.activeProducts,
    this.boostProducts,
    this.totalProducts,
  });

  factory ProductsList.fromJson(Map<String, dynamic> json) => ProductsList(
    activeProducts: json["active_products"] == null ? [] : List<Product>.from(json["active_products"]!.map((x) => Product.fromJson(x))),
    boostProducts: json["boost_products"] == null ? [] : List<Product>.from(json["boost_products"]!.map((x) => Product.fromJson(x))),
    totalProducts: json["total_products"] == null ? [] : List<Product>.from(json["total_products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "active_products": activeProducts == null ? [] : List<dynamic>.from(activeProducts!.map((x) => x.toJson())),
    "boost_products": boostProducts == null ? [] : List<dynamic>.from(boostProducts!.map((x) => x.toJson())),
    "total_products": totalProducts == null ? [] : List<dynamic>.from(totalProducts!.map((x) => x.toJson())),
  };
}

