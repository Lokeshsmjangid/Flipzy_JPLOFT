// To parse this JSON data, do
//
//     final supportReceiveMsgModel = supportReceiveMsgModelFromJson(jsonString);

import 'dart:convert';

import 'support_all_msg_model.dart';

SupportReceiveMsgModel supportReceiveMsgModelFromJson(String str) => SupportReceiveMsgModel.fromJson(json.decode(str));

String supportReceiveMsgModelToJson(SupportReceiveMsgModel data) => json.encode(data.toJson());

class SupportReceiveMsgModel {
  String? chatRoomId;
  String? senderId;
  String? receiverId;
  String? message;
  String? messageType;
  bool? session;
  bool? isRead;
  String? id;
  List<Attachment>? attachments;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SupportReceiveMsgModel({
    this.chatRoomId,
    this.senderId,
    this.receiverId,
    this.message,
    this.messageType,
    this.session,
    this.isRead,
    this.id,
    this.attachments,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SupportReceiveMsgModel.fromJson(Map<String, dynamic> json) => SupportReceiveMsgModel(
    chatRoomId: json["chatRoomId"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    message: json["message"],
    messageType: json["messageType"],
    session: json["session"],
    isRead: json["isRead"],
    id: json["_id"],
    attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "chatRoomId": chatRoomId,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "message": message,
    "messageType": messageType,
    "session": session,
    "isRead": isRead,
    "_id": id,
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
