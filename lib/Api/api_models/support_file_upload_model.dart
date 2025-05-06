// To parse this JSON data, do
//
//     final supportFileUploadModel = supportFileUploadModelFromJson(jsonString);

import 'dart:convert';

SupportFileUploadModel supportFileUploadModelFromJson(String str) => SupportFileUploadModel.fromJson(json.decode(str));

String supportFileUploadModelToJson(SupportFileUploadModel data) => json.encode(data.toJson());

class SupportFileUploadModel {
  String? message;
  bool? status;
  SupportUpload? data;

  SupportFileUploadModel({
    this.message,
    this.status,
    this.data,
  });

  factory SupportFileUploadModel.fromJson(Map<String, dynamic> json) => SupportFileUploadModel(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? null : SupportUpload.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data?.toJson(),
  };
}

class SupportUpload {
  String? url;
  String? fileType;
  String? originalName;

  SupportUpload({
    this.url,
    this.fileType,
    this.originalName,
  });

  factory SupportUpload.fromJson(Map<String, dynamic> json) => SupportUpload(
    url: json["url"],
    fileType: json["fileType"],
    originalName: json["originalName"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "fileType": fileType,
    "originalName": originalName,
  };
}
