// To parse this JSON data, do
//
//     final frequentlyAskQuestionsModel = frequentlyAskQuestionsModelFromJson(jsonString);

import 'dart:convert';

FrequentlyAskQuestionsModel frequentlyAskQuestionsModelFromJson(String str) => FrequentlyAskQuestionsModel.fromJson(json.decode(str));

String frequentlyAskQuestionsModelToJson(FrequentlyAskQuestionsModel data) => json.encode(data.toJson());

class FrequentlyAskQuestionsModel {
  String? message;
  bool? status;
  List<Faq>? data;

  FrequentlyAskQuestionsModel({
    this.message,
    this.status,
    this.data,
  });

  factory FrequentlyAskQuestionsModel.fromJson(Map<String, dynamic> json) => FrequentlyAskQuestionsModel(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? [] : List<Faq>.from(json["data"]!.map((x) => Faq.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Faq {
  String? id;
  String? question;
  String? details;
  String? status;
  bool? isSelect;

  Faq({
    this.id,
    this.question,
    this.details,
    this.status,
    this.isSelect = false
  });

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
    id: json["_id"],
    question: json["question"],
    details: json["details"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "details": details,
    "status": status,
  };
}
