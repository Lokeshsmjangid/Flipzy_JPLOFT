// To parse this JSON data, do
//
//     final boostPlansModel = boostPlansModelFromJson(jsonString);

import 'dart:convert';

BoostPlansModel boostPlansModelFromJson(String str) => BoostPlansModel.fromJson(json.decode(str));

String boostPlansModelToJson(BoostPlansModel data) => json.encode(data.toJson());

class BoostPlansModel {
  String? message;
  bool? status;
  List<BoostPlans>? data;

  BoostPlansModel({
    this.message,
    this.status,
    this.data,
  });

  factory BoostPlansModel.fromJson(Map<String, dynamic> json) => BoostPlansModel(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? [] : List<BoostPlans>.from(json["data"]!.map((x) => BoostPlans.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BoostPlans {
  String? id;
  String? plan;
  int? price;
  int? durationInDays;

  BoostPlans({
    this.id,
    this.plan,
    this.price,
    this.durationInDays,
  });

  factory BoostPlans.fromJson(Map<String, dynamic> json) => BoostPlans(
    id: json["_id"],
    plan: json["plan"],
    price: json["price"],
    durationInDays: json["durationInDays"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "plan": plan,
    "price": price,
    "durationInDays": durationInDays,
  };
}
