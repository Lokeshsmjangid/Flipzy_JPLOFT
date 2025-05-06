// To parse this JSON data, do
//
//     final chatWithUsersModel = chatWithUsersModelFromJson(jsonString);

import 'dart:convert';

ChatWithUsersModel chatWithUsersModelFromJson(String str) => ChatWithUsersModel.fromJson(json.decode(str));

String chatWithUsersModelToJson(ChatWithUsersModel data) => json.encode(data.toJson());

class ChatWithUsersModel {
  String? messages;
  bool? status;
  List<ChatWithUser>? data;

  ChatWithUsersModel({
    this.messages,
    this.status,
    this.data,
  });

  factory ChatWithUsersModel.fromJson(Map<String, dynamic> json) => ChatWithUsersModel(
    messages: json["messages"],
    status: json["status"],
    data: json["data"] == null ? [] : List<ChatWithUser>.from(json["data"]!.map((x) => ChatWithUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "messages": messages,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ChatWithUser {
  String? rowid;
  bool? isRead;
  bool? session;
  String? userId;
  String? firstname;
  String? profileImage;
  String? lastMessage;
  DateTime? createdAt;
  dynamic mobileNumber;
  bool? isOnline;
  dynamic unreadCount;

  ChatWithUser({
    this.rowid,
    this.isRead,
    this.session,
    this.userId,
    this.firstname,
    this.profileImage,
    this.lastMessage,
    this.createdAt,
    this.mobileNumber,
    this.isOnline,
    this.unreadCount
  });

  factory ChatWithUser.fromJson(Map<String, dynamic> json) => ChatWithUser(
    rowid: json["rowid"],
    isRead: json["isRead"],
    mobileNumber: json["mobileNumber"],
    isOnline: json["isOnline"],
    unreadCount: json["unreadCount"],
    session: json["session"],
    userId: json["userId"],
    firstname: json["firstname"],
    profileImage: json["profileImage"],
    lastMessage: json["lastMessage"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "rowid": rowid,
    "isRead": isRead,
    "mobileNumber": mobileNumber,
    "isOnline": isOnline,
    "unreadCount": unreadCount,
    "session": session,
    "userId": userId,
    "firstname": firstname,
    "profileImage": profileImage,
    "lastMessage": lastMessage,
    "createdAt": createdAt?.toIso8601String(),
  };
}
