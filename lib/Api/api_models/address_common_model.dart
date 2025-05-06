// To parse this JSON data, do
//
//     final addressCommonModel = addressCommonModelFromJson(jsonString);

import 'dart:convert';

import 'package:flipzy/Api/api_models/address_response_model.dart';

AddressCommonModel addressCommonModelFromJson(String str) => AddressCommonModel.fromJson(json.decode(str));

String addressCommonModelToJson(AddressCommonModel data) => json.encode(data.toJson());

class AddressCommonModel {
  bool? status;
  String? message;
  AddressModel? data;

  AddressCommonModel({
    this.status,
    this.message,
    this.data,
  });

  factory AddressCommonModel.fromJson(Map<String, dynamic> json) => AddressCommonModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : AddressModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}
