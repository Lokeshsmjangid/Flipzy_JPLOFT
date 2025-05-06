// To parse this JSON data, do
//
//     final notificationModelResponse = notificationModelResponseFromJson(jsonString);

import 'dart:convert';

NotificationModelResponse notificationModelResponseFromJson(String str) => NotificationModelResponse.fromJson(json.decode(str));

String notificationModelResponseToJson(NotificationModelResponse data) => json.encode(data.toJson());

class NotificationModelResponse {
  String? message;
  bool? status;
  List<Notification>? data;

  NotificationModelResponse({
    this.message,
    this.status,
    this.data,
  });

  factory NotificationModelResponse.fromJson(Map<String, dynamic> json) => NotificationModelResponse(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? [] : List<Notification>.from(json["data"]!.map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Notification {
  String? id;
  String? image;
  String? userId;
  String? senderId;
  String? title;
  String? message;
  dynamic data;
  String? type;
  bool? read;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Notification({
    this.id,
    this.image,
    this.userId,
    this.senderId,
    this.title,
    this.message,
    this.data,
    this.type,
    this.read,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["_id"],
    image: json["image"],
    userId: json["userId"],
    senderId: json["senderId"],
    title: json["title"],
    message: json["message"],
    data: json["data"],
    type: json["type"],
    read: json["read"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image": image,
    "userId": userId,
    "senderId": senderId,
    "title": title,
    "message": message,
    "data": data,
    "type": type,
    "read": read,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class DataClass {
  String? productId;
  String? discount;
  DateTime? validUntil;
  String? orderId;
  String? product;
  int? price;
  String? status;

  DataClass({
    this.productId,
    this.discount,
    this.validUntil,
    this.orderId,
    this.product,
    this.price,
    this.status,
  });

  factory DataClass.fromJson(Map<String, dynamic> json) => DataClass(
    productId: json["productId"],
    discount: json["discount"],
    validUntil: json["validUntil"] == null ? null : DateTime.parse(json["validUntil"]),
    orderId: json["orderId"],
    product: json["product"],
    price: json["price"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "discount": discount,
    "validUntil": "${validUntil!.year.toString().padLeft(4, '0')}-${validUntil!.month.toString().padLeft(2, '0')}-${validUntil!.day.toString().padLeft(2, '0')}",
    "orderId": orderId,
    "product": product,
    "price": price,
    "status": status,
  };
}
