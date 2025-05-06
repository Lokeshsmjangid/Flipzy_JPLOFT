// To parse this JSON data, do
//
//     final paymentVerifiedModel = paymentVerifiedModelFromJson(jsonString);

import 'dart:convert';

PaymentVerifiedModel paymentVerifiedModelFromJson(String str) => PaymentVerifiedModel.fromJson(json.decode(str));

String paymentVerifiedModelToJson(PaymentVerifiedModel data) => json.encode(data.toJson());

class PaymentVerifiedModel {
  bool? success;
  String? message;
  PaymentData? paymentData;

  PaymentVerifiedModel({
    this.success,
    this.message,
    this.paymentData,
  });

  factory PaymentVerifiedModel.fromJson(Map<String, dynamic> json) => PaymentVerifiedModel(
    success: json["success"],
    message: json["message"],
    paymentData: json["paymentData"] == null ? null : PaymentData.fromJson(json["paymentData"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "paymentData": paymentData?.toJson(),
  };
}

class PaymentData {
  int? id;
  String? txRef;
  String? flwRef;
  String? deviceFingerprint;
  int? amount;
  String? currency;
  int? chargedAmount;
  double? appFee;
  int? merchantFee;
  String? processorResponse;
  String? authModel;
  String? ip;
  String? narration;
  String? status;
  String? paymentType;
  DateTime? createdAt;
  int? accountId;
  Card? card;
  Meta? meta;
  double? amountSettled;
  Customer? customer;

  PaymentData({
    this.id,
    this.txRef,
    this.flwRef,
    this.deviceFingerprint,
    this.amount,
    this.currency,
    this.chargedAmount,
    this.appFee,
    this.merchantFee,
    this.processorResponse,
    this.authModel,
    this.ip,
    this.narration,
    this.status,
    this.paymentType,
    this.createdAt,
    this.accountId,
    this.card,
    this.meta,
    this.amountSettled,
    this.customer,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
    id: json["id"],
    txRef: json["tx_ref"],
    flwRef: json["flw_ref"],
    deviceFingerprint: json["device_fingerprint"],
    amount: json["amount"],
    currency: json["currency"],
    chargedAmount: json["charged_amount"],
    appFee: json["app_fee"]?.toDouble(),
    merchantFee: json["merchant_fee"],
    processorResponse: json["processor_response"],
    authModel: json["auth_model"],
    ip: json["ip"],
    narration: json["narration"],
    status: json["status"],
    paymentType: json["payment_type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    accountId: json["account_id"],
    card: json["card"] == null ? null : Card.fromJson(json["card"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    amountSettled: json["amount_settled"]?.toDouble(),
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tx_ref": txRef,
    "flw_ref": flwRef,
    "device_fingerprint": deviceFingerprint,
    "amount": amount,
    "currency": currency,
    "charged_amount": chargedAmount,
    "app_fee": appFee,
    "merchant_fee": merchantFee,
    "processor_response": processorResponse,
    "auth_model": authModel,
    "ip": ip,
    "narration": narration,
    "status": status,
    "payment_type": paymentType,
    "created_at": createdAt?.toIso8601String(),
    "account_id": accountId,
    "card": card?.toJson(),
    "meta": meta?.toJson(),
    "amount_settled": amountSettled,
    "customer": customer?.toJson(),
  };
}

class Card {
  String? first6Digits;
  String? last4Digits;
  String? issuer;
  String? country;
  String? type;
  String? token;
  String? expiry;

  Card({
    this.first6Digits,
    this.last4Digits,
    this.issuer,
    this.country,
    this.type,
    this.token,
    this.expiry,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    first6Digits: json["first_6digits"],
    last4Digits: json["last_4digits"],
    issuer: json["issuer"],
    country: json["country"],
    type: json["type"],
    token: json["token"],
    expiry: json["expiry"],
  );

  Map<String, dynamic> toJson() => {
    "first_6digits": first6Digits,
    "last_4digits": last4Digits,
    "issuer": issuer,
    "country": country,
    "type": type,
    "token": token,
    "expiry": expiry,
  };
}

class Customer {
  int? id;
  String? name;
  String? phoneNumber;
  String? email;
  DateTime? createdAt;

  Customer({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.createdAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone_number": phoneNumber,
    "email": email,
    "created_at": createdAt?.toIso8601String(),
  };
}

class Meta {
  String? checkoutInitAddress;

  Meta({
    this.checkoutInitAddress,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    checkoutInitAddress: json["__CheckoutInitAddress"],
  );

  Map<String, dynamic> toJson() => {
    "__CheckoutInitAddress": checkoutInitAddress,
  };
}
