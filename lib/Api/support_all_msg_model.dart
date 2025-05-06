// To parse this JSON data, do
//
//     final supportAllMsgChatModel = supportAllMsgChatModelFromJson(jsonString);

import 'dart:convert';

List<SupportAllMsgChatModel> supportAllMsgChatModelFromJson(String str) => List<SupportAllMsgChatModel>.from(json.decode(str).map((x) => SupportAllMsgChatModel.fromJson(x)));

String supportAllMsgChatModelToJson(List<SupportAllMsgChatModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupportAllMsgChatModel {
  String? id;
  String? chatRoomId;
  String? senderId;
  String? receiverId;
  String? message;
  String? messageType;
  bool? session;
  bool? isRead;
  List<Attachment>? attachments;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SupportAllMsgChatModel({
    this.id,
    this.chatRoomId,
    this.senderId,
    this.receiverId,
    this.message,
    this.messageType,
    this.session,
    this.isRead,
    this.attachments,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SupportAllMsgChatModel.fromJson(Map<String, dynamic> json) => SupportAllMsgChatModel(
    id: json["_id"],
    chatRoomId: json["chatRoomId"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    message: json["message"],
    messageType: json["messageType"],
    session: json["session"],
    isRead: json["isRead"],
    attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "chatRoomId": chatRoomId,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "message": message,
    "messageType": messageType,
    "session": session,
    "isRead": isRead,
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
class Attachment {
  String? id;
  String? url;
  String? fileType;

  Attachment({
    this.id,
    this.url,
    this.fileType,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    id: json["_id"],
    url: json["url"],
    fileType: json["fileType"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "url": url,
    "fileType": fileType,
  };
}