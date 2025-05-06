// To parse this JSON data, do
//
//     final myProductsModelResponse = myProductsModelResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flipzy/Api/api_models/home_model_response.dart';

MyProductsModelResponse myProductsModelResponseFromJson(String str) => MyProductsModelResponse.fromJson(json.decode(str));

String myProductsModelResponseToJson(MyProductsModelResponse data) => json.encode(data.toJson());

class MyProductsModelResponse {
  String? message;
  bool? status;
  int? totalProducts;
  int? page;
  int? limit;
  List<Product>? myProducts;

  MyProductsModelResponse({
    this.message,
    this.status,
    this.totalProducts,
    this.page,
    this.limit,
    this.myProducts,
  });

  factory MyProductsModelResponse.fromJson(Map<String, dynamic> json) => MyProductsModelResponse(
    message: json["message"],
    status: json["status"],
    totalProducts: json["totalProducts"],
    page: json["page"],
    limit: json["limit"],
    myProducts: json["data"] == null ? [] : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "totalProducts": totalProducts,
    "page": page,
    "limit": limit,
    "data": myProducts == null ? [] : List<dynamic>.from(myProducts!.map((x) => x.toJson())),
  };
}

