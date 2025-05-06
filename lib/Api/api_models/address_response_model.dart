// To parse this JSON data, do
//
//     final addressResponseModel = addressResponseModelFromJson(jsonString);

import 'dart:convert';

AddressResponseModel addressResponseModelFromJson(String str) => AddressResponseModel.fromJson(json.decode(str));

String addressResponseModelToJson(AddressResponseModel data) => json.encode(data.toJson());

class AddressResponseModel {
  String? message;
  bool? status;
  List<AddressModel>? data;

  AddressResponseModel({
    this.message,
    this.status,
    this.data,
  });

  factory AddressResponseModel.fromJson(Map<String, dynamic> json) => AddressResponseModel(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? [] : List<AddressModel>.from(json["data"]!.map((x) => AddressModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AddressModel {
  String? id;
  String? userId;
  double? lat;
  double? long;
  String? city;
  String? state;
  String? country;
  String? address;
  String? zipcode;
  String? landmark;
  bool? isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  AddressModel({
    this.id,
    this.userId,
    this.lat,
    this.long,
    this.city,
    this.state,
    this.country,
    this.address,
    this.zipcode,
    this.landmark,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["_id"],
    userId: json["userId"],
    lat: json["lat"]?.toDouble(),
    long: json["long"]?.toDouble(),
    city: json["city"],
    state: json["state"],
    country: json["country"],
    address: json["address"],
    zipcode: json["zipcode"],
    landmark: json["landmark"],
    isDefault: json["isDefault"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "lat": lat,
    "long": long,
    "city": city,
    "state": state,
    "country": country,
    "address": address,
    "zipcode": zipcode,
    "landmark": landmark,
    "isDefault": isDefault,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
