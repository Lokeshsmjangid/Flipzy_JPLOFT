// To parse this JSON data, do
//
//     final initiatePaymentModel = initiatePaymentModelFromJson(jsonString);

import 'dart:convert';

InitiatePaymentModel initiatePaymentModelFromJson(String str) => InitiatePaymentModel.fromJson(json.decode(str));

String initiatePaymentModelToJson(InitiatePaymentModel data) => json.encode(data.toJson());

class InitiatePaymentModel {
  bool? status;
  String? message;
  InitiatePayment? data;

  InitiatePaymentModel({
    this.status,
    this.message,
    this.data,
  });

  factory InitiatePaymentModel.fromJson(Map<String, dynamic> json) => InitiatePaymentModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : InitiatePayment.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class InitiatePayment {
  String? txRef;
  String? link;

  InitiatePayment({
    this.txRef,
    this.link,
  });

  factory InitiatePayment.fromJson(Map<String, dynamic> json) => InitiatePayment(
    txRef: json["tx_ref"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "tx_ref": txRef,
    "link": link,
  };
}
