// To parse this JSON data, do
//
//     final orderListResponse = orderListResponseFromJson(jsonString);

import 'dart:convert';

OrderListResponse orderListResponseFromJson(String str) => OrderListResponse.fromJson(json.decode(str));

String orderListResponseToJson(OrderListResponse data) => json.encode(data.toJson());

class OrderListResponse {
  String? message;
  bool? status;
  List<OrderData>? data;

  OrderListResponse({
    this.message,
    this.status,
    this.data,
  });

  factory OrderListResponse.fromJson(Map<String, dynamic> json) => OrderListResponse(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? [] : List<OrderData>.from(json["data"]!.map((x) => OrderData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class OrderData {
  String? orderId;
  int? totalAmount;
  String? paymentStatus;
  String? orderStatus;
  String? productId;
  List<String>? productImages;
  String? productName;
  ReturnRequestClass? returnRequest;
  String? shippingIndicator;

  OrderData({
    this.orderId,
    this.totalAmount,
    this.paymentStatus,
    this.orderStatus,
    this.productId,
    this.productImages,
    this.productName,
    this.returnRequest,
    this.shippingIndicator
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    orderId: json["orderId"],
    totalAmount: json["totalAmount"],
    paymentStatus: json["paymentStatus"],
    orderStatus: json["orderStatus"],
    productId: json["product_id"],
    productImages: json["productImages"] == null ? [] : List<String>.from(json["productImages"]!.map((x) => x)),
    productName: json["productName"],
    returnRequest: (json["returnRequest"] is Map<String, dynamic>)
        ? ReturnRequestClass.fromJson(json["returnRequest"])
        : null,
    shippingIndicator: json["shippingIndicator"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "totalAmount": totalAmount,
    "paymentStatus": paymentStatus,
    "orderStatus": orderStatus,
    "product_id": productId,
    "productImages": productImages == null ? [] : List<dynamic>.from(productImages!.map((x) => x)),
    "productName": productName,
    "returnRequest": returnRequest,
    "shippingIndicator": shippingIndicator,
  };
}

class ReturnRequestClass {
  bool? isRequested;
  String? reasonType;
  String? reason;
  List<String>? images;
  DateTime? requestDate;
  String? status;
  String? declineReason;
  String? declinedBy;
  bool? pickupScheduled;
  bool? productPickedUp;
  DateTime? reviewDate;
  String? reviewedBy;

  ReturnRequestClass({
    this.isRequested,
    this.reasonType,
    this.reason,
    this.images,
    this.requestDate,
    this.status,
    this.declineReason,
    this.declinedBy,
    this.pickupScheduled,
    this.productPickedUp,
    this.reviewDate,
    this.reviewedBy,
  });

  factory ReturnRequestClass.fromJson(Map<String, dynamic> json) => ReturnRequestClass(
    isRequested: json["isRequested"],
    reasonType: json["reasonType"],
    reason: json["reason"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    requestDate: json["requestDate"] == null ? null : DateTime.parse(json["requestDate"]),
    status: json["status"],
    declineReason: json["declineReason"],
    declinedBy: json["declinedBy"],
    pickupScheduled: json["pickupScheduled"],
    productPickedUp: json["productPickedUp"],
    reviewDate: json["reviewDate"] == null ? null : DateTime.parse(json["reviewDate"]),
    reviewedBy: json["reviewedBy"],
  );

  Map<String, dynamic> toJson() => {
    "isRequested": isRequested,
    "reasonType": reasonType,
    "reason": reason,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "requestDate": requestDate?.toIso8601String(),
    "status": status,
    "declineReason": declineReason,
    "declinedBy": declinedBy,
    "pickupScheduled": pickupScheduled,
    "productPickedUp": productPickedUp,
    "reviewDate": reviewDate?.toIso8601String(),
    "reviewedBy": reviewedBy,
  };
}
