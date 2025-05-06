// To parse this JSON data, do
//
//     final commonModelResponse = commonModelResponseFromJson(jsonString);

import 'dart:convert';

import 'user_model.dart';

CommonModelResponse commonModelResponseFromJson(String str) => CommonModelResponse.fromJson(json.decode(str));

String commonModelResponseToJson(CommonModelResponse data) => json.encode(data.toJson());

class CommonModelResponse {
  bool? status;
  String? message;
  dynamic otp;
  String? token;

  UserModel? data;
  dynamic totalAmount;
  dynamic totalActive;
  dynamic totalorder;
  String? paymentLink;
  String? tx_ref;

  CommonModelResponse({
    this.status,
    this.message,
    this.otp,
    this.token,
    this.data,
    this.totalAmount,
    this.totalActive,
    this.totalorder,
    this.paymentLink,
    this.tx_ref,
  });

  factory CommonModelResponse.fromJson(Map<String, dynamic> json) => CommonModelResponse(
    status: json["status"],
    message: json["message"] == null ? '' :json["message"],
    otp: json["otp"],
    token: json["token"] == null ? '' : json["token"],
    data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
    totalAmount: json["totalAmount"],
    totalActive: json["totalActive"],
    totalorder: json["totalorder"],
    paymentLink: json["paymentLink"],
    tx_ref: json["tx_ref"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "otp": otp,
    "token": token,
    "data": data?.toJson(),
    "totalAmount": totalAmount,
    "totalActive": totalActive,
    "totalorder": totalorder,
    "paymentLink": paymentLink,
    "tx_ref": tx_ref,
  };
}
