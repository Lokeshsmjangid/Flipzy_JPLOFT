// To parse this JSON data, do
//
//     final getAllMessagesResponse = getAllMessagesResponseFromJson(jsonString);

import 'dart:convert';

List<GetAllMessagesResponse> getAllMessagesResponseFromJson(String str) => List<GetAllMessagesResponse>.from(json.decode(str).map((x) => GetAllMessagesResponse.fromJson(x)));

String getAllMessagesResponseToJson(List<GetAllMessagesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllMessagesResponse {
  String? id;
  String? senderId;
  String? receiverId;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  GetAllMessagesResponse({
    this.id,
    this.senderId,
    this.receiverId,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory GetAllMessagesResponse.fromJson(Map<String, dynamic> json) => GetAllMessagesResponse(
    id: json["_id"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    message: json["message"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "message": message,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),

  };
}

