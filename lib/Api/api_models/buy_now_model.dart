// To parse this JSON data, do
//
//     final buyNowModelResponse = buyNowModelResponseFromJson(jsonString);

import 'dart:convert';

BuyNowModelResponse buyNowModelResponseFromJson(String str) => BuyNowModelResponse.fromJson(json.decode(str));

String buyNowModelResponseToJson(BuyNowModelResponse data) => json.encode(data.toJson());

class BuyNowModelResponse {
  String? message;
  bool? status;
  Data? data;

  BuyNowModelResponse({
    this.message,
    this.status,
    this.data,
  });

  factory BuyNowModelResponse.fromJson(Map<String, dynamic> json) => BuyNowModelResponse(
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
  int? deliveryCharge;
  int? discount;
  DateTime? createdTranscation;
  String? trackingId;
  List<DeliveryUpdate>? deliveryUpdates;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

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
    this.deliveryCharge,
    this.discount,
    this.createdTranscation,
    this.trackingId,
    this.deliveryUpdates,
    this.createdAt,
    this.updatedAt,
    this.v,
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
    deliveryCharge: json["deliveryCharge"],
    discount: json["discount"],
    createdTranscation: json["created_Transcation"] == null ? null : DateTime.parse(json["created_Transcation"]),
    trackingId: json["trackingId"],
    deliveryUpdates: json["deliveryUpdates"] == null ? [] : List<DeliveryUpdate>.from(json["deliveryUpdates"]!.map((x) => DeliveryUpdate.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
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
    "deliveryCharge": deliveryCharge,
    "discount": discount,
    "created_Transcation": createdTranscation?.toIso8601String(),
    "trackingId": trackingId,
    "deliveryUpdates": deliveryUpdates == null ? [] : List<dynamic>.from(deliveryUpdates!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
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
  DateTime? timestamp;

  DeliveryUpdate({
    this.id,
    this.timestamp,
  });

  factory DeliveryUpdate.fromJson(Map<String, dynamic> json) => DeliveryUpdate(
    id: json["_id"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "timestamp": timestamp?.toIso8601String(),
  };
}

class Product {
  String? sellerId;
  String? productId;
  int? quantity;
  int? price;
  Variations? variations;
  String? id;

  Product({
    this.sellerId,
    this.productId,
    this.quantity,
    this.price,
    this.variations,
    this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    sellerId: json["sellerId"],
    productId: json["productId"],
    quantity: json["quantity"],
    price: json["price"],
    variations: json["variations"] == null ? null : Variations.fromJson(json["variations"]),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "sellerId": sellerId,
    "productId": productId,
    "quantity": quantity,
    "price": price,
    "variations": variations?.toJson(),
    "_id": id,
  };
}

class Variations {
  String? variationsNew;

  Variations({
    this.variationsNew,
  });

  factory Variations.fromJson(Map<String, dynamic> json) => Variations(
    variationsNew: json["new"],
  );

  Map<String, dynamic> toJson() => {
    "new": variationsNew,
  };
}

class ReturnDays {
  String? timeInday;

  ReturnDays({
    this.timeInday,
  });

  factory ReturnDays.fromJson(Map<String, dynamic> json) => ReturnDays(
    timeInday: json["timeInday"],
  );

  Map<String, dynamic> toJson() => {
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
