// To parse this JSON data, do
//
//     final userBalanceResponse = userBalanceResponseFromJson(jsonString);

import 'dart:convert';

UserBalanceResponse userBalanceResponseFromJson(String str) => UserBalanceResponse.fromJson(json.decode(str));

String userBalanceResponseToJson(UserBalanceResponse data) => json.encode(data.toJson());

class UserBalanceResponse {
  bool? success;
  String? message;
  AvailableBalance? data;

  UserBalanceResponse({
    this.success,
    this.message,
    this.data,
  });

  factory UserBalanceResponse.fromJson(Map<String, dynamic> json) => UserBalanceResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : AvailableBalance.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class AvailableBalance {
  Summary? summary;
  List<TransactionDetail>? transactions;

  AvailableBalance({
    this.summary,
    this.transactions,
  });

  factory AvailableBalance.fromJson(Map<String, dynamic> json) => AvailableBalance(
    summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
    transactions: json["transactions"] == null ? [] : List<TransactionDetail>.from(json["transactions"]!.map((x) => TransactionDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "summary": summary?.toJson(),
    "transactions": transactions == null ? [] : List<dynamic>.from(transactions!.map((x) => x.toJson())),
  };
}

class Summary {
  double? totalEarnings;
  double? availableBalance;
  int? withdrawnBalance;

  Summary({
    this.totalEarnings,
    this.availableBalance,
    this.withdrawnBalance,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    totalEarnings: json["totalEarnings"]?.toDouble(),
    availableBalance: json["availableBalance"]?.toDouble(),
    withdrawnBalance: json["withdrawnBalance"],
  );

  Map<String, dynamic> toJson() => {
    "totalEarnings": totalEarnings,
    "availableBalance": availableBalance,
    "withdrawnBalance": withdrawnBalance,
  };
}

class TransactionDetail {
  String? orderId;
  String? productId;
  String? productName;
  String? price;
  double? netReceived;
  String? trackingId;
  DateTime? orderDate;

  TransactionDetail({
    this.orderId,
    this.productId,
    this.productName,
    this.price,
    this.netReceived,
    this.trackingId,
    this.orderDate,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) => TransactionDetail(
    orderId: json["orderId"],
    productId: json["productId"],
    productName: json["productName"],
    price: json["price"],
    netReceived: json["netReceived"]?.toDouble(),
    trackingId: json["trackingId"],
    orderDate: json["orderDate"] == null ? null : DateTime.parse(json["orderDate"]),
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "productId": productId,
    "productName": productName,
    "price": price,
    "netReceived": netReceived,
    "trackingId": trackingId,
    "orderDate": orderDate?.toIso8601String(),
  };
}
