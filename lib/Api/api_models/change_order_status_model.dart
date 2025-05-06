// To parse this JSON data, do
//
//     final orderStatusResponse = orderStatusResponseFromJson(jsonString);

import 'dart:convert';

OrderStatusResponse orderStatusResponseFromJson(String str) => OrderStatusResponse.fromJson(json.decode(str));

String orderStatusResponseToJson(OrderStatusResponse data) => json.encode(data.toJson());

class OrderStatusResponse {
  String? message;
  bool? status;
  Data? data;

  OrderStatusResponse({
    this.message,
    this.status,
    this.data,
  });

  factory OrderStatusResponse.fromJson(Map<String, dynamic> json) => OrderStatusResponse(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  ReturnDays? returnDays;
  ShippingAddress? shippingAddress;
  CourierDetails? courierDetails;
  String? id;
  String? userId;
  List<Product>? products;
  int? totalAmount;
  String? paymentStatus;
  String? paymentMethod;
  String? transactionId;
  bool? isEarningsAdded;
  String? orderStatus;
  String? currency;
  String? ipAddress;
  DateTime? createdTranscation;
  String? trackingId;
  List<DeliveryUpdate>? deliveryUpdates;
  DateTime? estimatedDelivery;
  int? deliveryCharge;
  int? discount;
  DateTime? updatedAt;

  Data({
    this.returnDays,
    this.shippingAddress,
    this.courierDetails,
    this.id,
    this.userId,
    this.products,
    this.totalAmount,
    this.paymentStatus,
    this.paymentMethod,
    this.transactionId,
    this.isEarningsAdded,
    this.orderStatus,
    this.currency,
    this.ipAddress,
    this.createdTranscation,
    this.trackingId,
    this.deliveryUpdates,
    this.estimatedDelivery,
    this.deliveryCharge,
    this.discount,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    returnDays: json["returnDays"] == null ? null : ReturnDays.fromJson(json["returnDays"]),
    shippingAddress: json["shippingAddress"] == null ? null : ShippingAddress.fromJson(json["shippingAddress"]),
    courierDetails: json["courierDetails"] == null ? null : CourierDetails.fromJson(json["courierDetails"]),
    id: json["_id"],
    userId: json["userId"],
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    totalAmount: json["totalAmount"],
    paymentStatus: json["paymentStatus"],
    paymentMethod: json["paymentMethod"],
    transactionId: json["transactionId"],
    isEarningsAdded: json["isEarningsAdded"],
    orderStatus: json["orderStatus"],
    currency: json["currency"],
    ipAddress: json["ip_address"],
    createdTranscation: json["created_Transcation"] == null ? null : DateTime.parse(json["created_Transcation"]),
    trackingId: json["trackingId"],
    deliveryUpdates: json["deliveryUpdates"] == null ? [] : List<DeliveryUpdate>.from(json["deliveryUpdates"]!.map((x) => DeliveryUpdate.fromJson(x))),
    estimatedDelivery: json["estimatedDelivery"] == null ? null : DateTime.parse(json["estimatedDelivery"]),
    deliveryCharge: json["deliveryCharge"],
    discount: json["discount"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "returnDays": returnDays?.toJson(),
    "shippingAddress": shippingAddress?.toJson(),
    "courierDetails": courierDetails?.toJson(),
    "_id": id,
    "userId": userId,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "totalAmount": totalAmount,
    "paymentStatus": paymentStatus,
    "paymentMethod": paymentMethod,
    "transactionId": transactionId,
    "isEarningsAdded": isEarningsAdded,
    "orderStatus": orderStatus,
    "currency": currency,
    "ip_address": ipAddress,
    "created_Transcation": createdTranscation?.toIso8601String(),
    "trackingId": trackingId,
    "deliveryUpdates": deliveryUpdates == null ? [] : List<dynamic>.from(deliveryUpdates!.map((x) => x.toJson())),
    "estimatedDelivery": estimatedDelivery?.toIso8601String(),
    "deliveryCharge": deliveryCharge,
    "discount": discount,
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class CourierDetails {
  String? courierName;
  String? trackingNumber;

  CourierDetails({
    this.courierName,
    this.trackingNumber,
  });

  factory CourierDetails.fromJson(Map<String, dynamic> json) => CourierDetails(
    courierName: json["courierName"],
    trackingNumber: json["trackingNumber"],
  );

  Map<String, dynamic> toJson() => {
    "courierName": courierName,
    "trackingNumber": trackingNumber,
  };
}

class DeliveryUpdate {
  String? id;
  String? location;
  DateTime? timestamp;
  String? remarks;

  DeliveryUpdate({
    this.id,
    this.location,
    this.timestamp,
    this.remarks,
  });

  factory DeliveryUpdate.fromJson(Map<String, dynamic> json) => DeliveryUpdate(
    id: json["_id"],
    location: json["location"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "location": location,
    "timestamp": timestamp?.toIso8601String(),
    "remarks": remarks,
  };
}

class Product {
  String? id;
  String? sellerId;
  String? productId;
  int? quantity;
  int? price;
  Variations? variations;

  Product({
    this.id,
    this.sellerId,
    this.productId,
    this.quantity,
    this.price,
    this.variations,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    sellerId: json["sellerId"],
    productId: json["productId"],
    quantity: json["quantity"],
    price: json["price"],
    variations: json["variations"] == null ? null : Variations.fromJson(json["variations"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sellerId": sellerId,
    "productId": productId,
    "quantity": quantity,
    "price": price,
    "variations": variations?.toJson(),
  };
}

class Variations {
  String? color;
  String? size;

  Variations({
    this.color,
    this.size,
  });

  factory Variations.fromJson(Map<String, dynamic> json) => Variations(
    color: json["color"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "color": color,
    "size": size,
  };
}

class ReturnDays {
  DateTime? date;
  String? timeInday;

  ReturnDays({
    this.date,
    this.timeInday,
  });

  factory ReturnDays.fromJson(Map<String, dynamic> json) => ReturnDays(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    timeInday: json["timeInday"],
  );

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String(),
    "timeInday": timeInday,
  };
}

class ShippingAddress {
  String? fullName;
  String? address;
  String? city;
  String? state;
  String? zipCode;
  String? country;
  String? mobileNumber;

  ShippingAddress({
    this.fullName,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    this.mobileNumber,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
    fullName: json["fullName"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    zipCode: json["zipCode"],
    country: json["country"],
    mobileNumber: json["mobileNumber"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "address": address,
    "city": city,
    "state": state,
    "zipCode": zipCode,
    "country": country,
    "mobileNumber": mobileNumber,
  };
}
