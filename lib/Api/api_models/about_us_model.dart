// To parse this JSON data, do
//
//     final aboutUsModel = aboutUsModelFromJson(jsonString);

import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) => AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
  String? message;
  bool? status;
  AboutUs? data;

  AboutUsModel({
    this.message,
    this.status,
    this.data,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? null : AboutUs.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data?.toJson(),
  };
}

class AboutUs {
  String? title;
  String? status;
  String? details;
  String? content;
  String? companyPolicy;

  AboutUs({
    this.title,
    this.details,
    this.status,
    this.content,
    this.companyPolicy,
  });

  factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
    title: json["title"],
    status: json["status"],
    details: json["details"],
    content: json["content"],
    companyPolicy: json["companyPolicy"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "status": status,
    "details": details,
    "content": content,
    "companyPolicy": companyPolicy,
  };
}
