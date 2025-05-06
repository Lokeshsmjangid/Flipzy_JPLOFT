// To parse this JSON data, do
//
//     final transactionResponse = transactionResponseFromJson(jsonString);

import 'dart:convert';

TransactionResponse transactionResponseFromJson(String str) => TransactionResponse.fromJson(json.decode(str));

String transactionResponseToJson(TransactionResponse data) => json.encode(data.toJson());

class TransactionResponse {
  String? message;
  bool? status;
  List<Datum>? data;

  TransactionResponse({
    this.message,
    this.status,
    this.data,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) => TransactionResponse(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? userId;
  int? balance;
  List<Transaction>? transactions;

  Datum({
    this.id,
    this.userId,
    this.balance,
    this.transactions,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    userId: json["userId"],
    balance: json["balance"],
    transactions: json["transactions"] == null ? [] : List<Transaction>.from(json["transactions"]!.map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "balance": balance,
    "transactions": transactions == null ? [] : List<dynamic>.from(transactions!.map((x) => x.toJson())),
  };
}

class Transaction {
  String? id;
  String? type;
  int? amount;
  DateTime? timestamp;

  Transaction({
    this.id,
    this.type,
    this.amount,
    this.timestamp,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["_id"],
    type: json["type"],
    amount: json["amount"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "type": type,
    "amount": amount,
    "timestamp": timestamp?.toIso8601String(),
  };
}
