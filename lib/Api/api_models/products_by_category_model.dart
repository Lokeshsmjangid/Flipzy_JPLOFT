// To parse this JSON data, do
//
//     final productsByCategoryModelResponse = productsByCategoryModelResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flipzy/Api/api_models/home_model_response.dart';

ProductsByCategoryModelResponse productsByCategoryModelResponseFromJson(String str) => ProductsByCategoryModelResponse.fromJson(json.decode(str));

String productsByCategoryModelResponseToJson(ProductsByCategoryModelResponse data) => json.encode(data.toJson());

class ProductsByCategoryModelResponse {
  bool? status;
  String? message;
  List<Product>? data;

  ProductsByCategoryModelResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ProductsByCategoryModelResponse.fromJson(Map<String, dynamic> json) => ProductsByCategoryModelResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
