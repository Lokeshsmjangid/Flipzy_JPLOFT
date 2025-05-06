// To parse this JSON data, do
//
//     final orderDetailResponse = orderDetailResponseFromJson(jsonString);

import 'dart:convert';

OrderDetailResponse orderDetailResponseFromJson(String str) => OrderDetailResponse.fromJson(json.decode(str));

String orderDetailResponseToJson(OrderDetailResponse data) => json.encode(data.toJson());

class OrderDetailResponse {
  String? message;
  bool? status;
  List<Datum>? data;

  OrderDetailResponse({
    this.message,
    this.status,
    this.data,
  });

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) => OrderDetailResponse(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? userId;
  Products? products;
  int? totalAmount;
  String? paymentStatus;
  String? paymentMethod;
  String? transactionId;
  bool? isEarningsAdded;
  String? orderStatus;
  String? currency;
  String? ipAddress;
  ReturnDays? returnDays;
  ShippingAddress? shippingAddress;
  DateTime? createdTranscation;
  String? trackingId;
  CourierDetails? courierDetails;
  List<DeliveryUpdate>? deliveryUpdates;
  DateTime? estimatedDelivery;
  ProductDetails? productDetails;
  bool? isProductPickedUp;
  DateTime? orderDate;
  String? refundStatus;
  int? refundAmount;
  int? shippingCharges;
  DateTime? refundDate;
  String? refundReason;
  String? refundRejectionReason;
  String? declinedBy;
  bool? isReturnAvailable;

  Datum({
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
    this.returnDays,
    this.shippingAddress,
    this.createdTranscation,
    this.trackingId,
    this.courierDetails,
    this.deliveryUpdates,
    this.estimatedDelivery,
    this.productDetails,
    this.orderDate,
    this.refundStatus,
    this.refundAmount,
    this.isProductPickedUp,
    this.refundDate,
    this.refundReason,
    this.refundRejectionReason,
    this.declinedBy,
    this.shippingCharges,
    this.isReturnAvailable,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    userId: json["userId"],
    products: json["products"] == null ? null : Products.fromJson(json["products"]),
    totalAmount: json["totalAmount"],
    paymentStatus: json["paymentStatus"],
    paymentMethod: json["paymentMethod"],
    transactionId: json["transactionId"],
    isEarningsAdded: json["isEarningsAdded"],
    orderStatus: json["orderStatus"],
    currency: json["currency"],
    ipAddress: json["ip_address"],
    returnDays: json["returnDays"] == null ? null : ReturnDays.fromJson(json["returnDays"]),
    shippingAddress: json["shippingAddress"] == null ? null : ShippingAddress.fromJson(json["shippingAddress"]),
    createdTranscation: json["created_Transcation"] == null ? null : DateTime.parse(json["created_Transcation"]),
    trackingId: json["trackingId"],
    courierDetails: json["courierDetails"] == null ? null : CourierDetails.fromJson(json["courierDetails"]),
    deliveryUpdates: json["deliveryUpdates"] == null ? [] : List<DeliveryUpdate>.from(json["deliveryUpdates"]!.map((x) => DeliveryUpdate.fromJson(x))),
    estimatedDelivery: json["estimatedDelivery"] == null ? null : DateTime.parse(json["estimatedDelivery"]),
    productDetails: json["productDetails"] == null ? null : ProductDetails.fromJson(json["productDetails"]),
    orderDate: json["orderDate"] == null ? null : DateTime.parse(json["orderDate"]),
    refundStatus: json["refundStatus"],
    refundAmount: json["refundAmount"],
    shippingCharges: json["shippingCharges"],
    isProductPickedUp: json["isProductPickedUp"],
    refundDate: json["refundDate"] == null ? null : DateTime.parse(json["refundDate"]),
    refundReason: json["refundReason"],
    refundRejectionReason: json["refundRejectionReason"],
    declinedBy: json["declinedBy"],
    isReturnAvailable: json["isReturnAvailable"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "products": products?.toJson(),
    "totalAmount": totalAmount,
    "paymentStatus": paymentStatus,
    "paymentMethod": paymentMethod,
    "transactionId": transactionId,
    "isEarningsAdded": isEarningsAdded,
    "orderStatus": orderStatus,
    "currency": currency,
    "ip_address": ipAddress,
    "returnDays": returnDays?.toJson(),
    "shippingAddress": shippingAddress?.toJson(),
    "created_Transcation": createdTranscation?.toIso8601String(),
    "trackingId": trackingId,
    "courierDetails": courierDetails?.toJson(),
    "deliveryUpdates": deliveryUpdates == null ? [] : List<dynamic>.from(deliveryUpdates!.map((x) => x.toJson())),
    "estimatedDelivery": estimatedDelivery?.toIso8601String(),
    "productDetails": productDetails?.toJson(),
    "orderDate": orderDate?.toIso8601String(),
    "refundStatus": refundStatus,
    "refundAmount": refundAmount,
    "shippingCharges": shippingCharges,
    "isProductPickedUp": isProductPickedUp,
    "refundDate": refundDate?.toIso8601String(),
    "refundReason": refundReason,
    "refundRejectionReason": refundRejectionReason,
    "declinedBy": declinedBy,
    "isReturnAvailable": isReturnAvailable,
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
  String? location;
  DateTime? timestamp;
  String? remarks;

  DeliveryUpdate({
    this.location,
    this.timestamp,
    this.remarks,
  });

  factory DeliveryUpdate.fromJson(Map<String, dynamic> json) => DeliveryUpdate(
    location: json["location"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "location": location,
    "timestamp": timestamp?.toIso8601String(),
    "remarks": remarks,
  };
}

class ProductDetails {
  String? id;
  List<String>? productImages;
  String? sellerId;
  String? userType;
  String? brandName;
  String? productName;
  String? catagory;
  String? price;
  String? productDescription;
  String? productWeight;
  String? productDimentions;
  bool? localPickUp;
  bool? bestseller;
  bool? featured;
  int? availableProduct;
  String? deliveryCity;
  int? deliveryRate;
  String? sellBeyondCityLimits;
  int? stockQuantity;
  String? stock;
  List<dynamic>? boostProduct;
  List<dynamic>? declineReason;
  List<dynamic>? refund;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<dynamic>? favIcon;
  bool? isfavIcon;
  int? deliveryCharge;
  int? discount;

  ProductDetails({
    this.id,
    this.productImages,
    this.sellerId,
    this.userType,
    this.brandName,
    this.productName,
    this.catagory,
    this.price,
    this.productDescription,
    this.productWeight,
    this.productDimentions,
    this.localPickUp,
    this.bestseller,
    this.featured,
    this.availableProduct,
    this.deliveryCity,
    this.deliveryRate,
    this.sellBeyondCityLimits,
    this.stockQuantity,
    this.stock,
    this.boostProduct,
    this.declineReason,
    this.refund,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.favIcon,
    this.isfavIcon,
    this.deliveryCharge,
    this.discount,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    id: json["_id"],
    productImages: json["productImages"] == null ? [] : List<String>.from(json["productImages"]!.map((x) => x)),
    sellerId: json["sellerId"],
    userType: json["userType"],
    brandName: json["brandName"],
    productName: json["productName"],
    catagory: json["catagory"],
    price: json["price"],
    productDescription: json["productDescription"],
    productWeight: json["productWeight"],
    productDimentions: json["productDimentions"],
    localPickUp: json["localPickUp"],
    bestseller: json["bestseller"],
    featured: json["featured"],
    availableProduct: json["availableProduct"],
    deliveryCity: json["deliveryCity"],
    deliveryRate: json["deliveryRate"],
    sellBeyondCityLimits: json["sellBeyondCityLimits"],
    stockQuantity: json["stockQuantity"],
    stock: json["stock"],
    boostProduct: json["boostProduct"] == null ? [] : List<dynamic>.from(json["boostProduct"]!.map((x) => x)),
    declineReason: json["declineReason"] == null ? [] : List<dynamic>.from(json["declineReason"]!.map((x) => x)),
    refund: json["refund"] == null ? [] : List<dynamic>.from(json["refund"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    favIcon: json["favIcon"] == null ? [] : List<dynamic>.from(json["favIcon"]!.map((x) => x)),
    isfavIcon: json["isfavIcon"],
    deliveryCharge: json["deliveryCharge"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productImages": productImages == null ? [] : List<dynamic>.from(productImages!.map((x) => x)),
    "sellerId": sellerId,
    "userType": userType,
    "brandName": brandName,
    "productName": productName,
    "catagory": catagory,
    "price": price,
    "productDescription": productDescription,
    "productWeight": productWeight,
    "productDimentions": productDimentions,
    "localPickUp": localPickUp,
    "bestseller": bestseller,
    "featured": featured,
    "availableProduct": availableProduct,
    "deliveryCity": deliveryCity,
    "deliveryRate": deliveryRate,
    "sellBeyondCityLimits": sellBeyondCityLimits,
    "stockQuantity": stockQuantity,
    "stock": stock,
    "boostProduct": boostProduct == null ? [] : List<dynamic>.from(boostProduct!.map((x) => x)),
    "declineReason": declineReason == null ? [] : List<dynamic>.from(declineReason!.map((x) => x)),
    "refund": refund == null ? [] : List<dynamic>.from(refund!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "favIcon": favIcon == null ? [] : List<dynamic>.from(favIcon!.map((x) => x)),
    "isfavIcon": isfavIcon,
    "deliveryCharge": deliveryCharge,
    "discount": discount,
  };
}

class Products {
  String? sellerId;
  String? productId;
  int? quantity;
  String? price;
  Variations? variations;
  String? productName;
  List<String>? productImages;

  Products({
    this.sellerId,
    this.productId,
    this.quantity,
    this.price,
    this.variations,
    this.productName,
    this.productImages,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    sellerId: json["sellerId"],
    productId: json["productId"],
    quantity: json["quantity"],
    price: json["price"],
    variations: json["variations"] == null ? null : Variations.fromJson(json["variations"]),
    productName: json["productName"],
    productImages: json["productImages"] == null ? [] : List<String>.from(json["productImages"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "sellerId": sellerId,
    "productId": productId,
    "quantity": quantity,
    "price": price,
    "variations": variations?.toJson(),
    "productName": productName,
    "productImages": productImages == null ? [] : List<dynamic>.from(productImages!.map((x) => x)),
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
