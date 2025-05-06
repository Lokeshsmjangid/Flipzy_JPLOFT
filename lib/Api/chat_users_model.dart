// To parse this JSON data, do
//
//     final chatUsersResponse = chatUsersResponseFromJson(jsonString);

import 'dart:convert';

List<ChatUsersResponse> chatUsersResponseFromJson(String str) => List<ChatUsersResponse>.from(json.decode(str).map((x) => ChatUsersResponse.fromJson(x)));

String chatUsersResponseToJson(List<ChatUsersResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatUsersResponse {
  String? userId;
  String? firstname;
  String? profileImage;
  String? lastMessage;
  DateTime? createdAt;

  ChatUsersResponse({
    this.userId,
    this.firstname,
    this.profileImage,
    this.lastMessage,
    this.createdAt,
  });

  factory ChatUsersResponse.fromJson(Map<String, dynamic> json) => ChatUsersResponse(
    userId: json["userId"],
    firstname: json["firstname"],
    profileImage: json["profileImage"],
    lastMessage: json["lastMessage"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "firstname": firstname,
    "profileImage": profileImage,
    "lastMessage": lastMessage,
    "createdAt": createdAt?.toIso8601String(),
  };
}
