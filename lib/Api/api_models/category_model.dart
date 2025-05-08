// To parse this JSON data, do
//
//     final categoryModelResponse = categoryModelResponseFromJson(jsonString);

import 'dart:convert';

CategoryModelResponse categoryModelResponseFromJson(String str) => CategoryModelResponse.fromJson(json.decode(str));

String categoryModelResponseToJson(CategoryModelResponse data) => json.encode(data.toJson());

class CategoryModelResponse {
  bool? status;
  String? message;
  int? page;
  int? limit;
  int? totalPages;
  List<Category>? data;

  CategoryModelResponse({
    this.status,
    this.message,
    this.page,
    this.limit,
    this.totalPages,
    this.data,
  });

  factory CategoryModelResponse.fromJson(Map<String, dynamic> json) => CategoryModelResponse(
    status: json["status"],
    message: json["message"],
    page: json["page"],
    limit: json["limit"],
    totalPages: json["totalPages"],
    data: json["data"] == null ? [] : List<Category>.from(json["data"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Category {
  String? id;
  String? name;
  String? image;
  int? commission;

  Category({
    this.id,
    this.name,
    this.image,
    this.commission,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    name: json["name"],
    image: json["image"],
    commission: json["commission"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
    "commission": commission,
  };
}
