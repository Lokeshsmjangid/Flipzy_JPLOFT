// To parse this JSON data, do
//
//     final shipBubbleModel = shipBubbleModelFromJson(jsonString);

import 'dart:convert';

ShipBubbleModel shipBubbleModelFromJson(String str) => ShipBubbleModel.fromJson(json.decode(str));

String shipBubbleModelToJson(ShipBubbleModel data) => json.encode(data.toJson());

class ShipBubbleModel {
  String? status;
  String? message;
  ShipBubbleModelData? data;

  ShipBubbleModel({
    this.status,
    this.message,
    this.data,
  });

  factory ShipBubbleModel.fromJson(Map<String, dynamic> json) => ShipBubbleModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : ShipBubbleModelData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ShipBubbleModelData {
  dynamic shippingLabel;
  Validation? fromValidation;
  Validation? toValidation;
  BestFitBox? bestFitBox;
  BestCourier? bestCourier;
  ShippingRate? shippingRate;
  Insurance? insurance;

  ShipBubbleModelData({
    this.shippingLabel,
    this.fromValidation,
    this.toValidation,
    this.bestFitBox,
    this.bestCourier,
    this.shippingRate,
    this.insurance,
  });

  factory ShipBubbleModelData.fromJson(Map<String, dynamic> json) => ShipBubbleModelData(
    shippingLabel: json["shippingLabel"],
    fromValidation: json["fromValidation"] == null ? null : Validation.fromJson(json["fromValidation"]),
    toValidation: json["toValidation"] == null ? null : Validation.fromJson(json["toValidation"]),
    bestFitBox: json["bestFitBox"] == null ? null : BestFitBox.fromJson(json["bestFitBox"]),
    bestCourier: json["bestCourier"] == null ? null : BestCourier.fromJson(json["bestCourier"]),
    shippingRate: json["shippingRate"] == null ? null : ShippingRate.fromJson(json["shippingRate"]),
    insurance: json["insurance"] == null ? null : Insurance.fromJson(json["insurance"]),
  );

  Map<String, dynamic> toJson() => {
    "shippingLabel": shippingLabel,
    "fromValidation": fromValidation?.toJson(),
    "toValidation": toValidation?.toJson(),
    "bestFitBox": bestFitBox?.toJson(),
    "bestCourier": bestCourier?.toJson(),
    "shippingRate": shippingRate?.toJson(),
    "insurance": insurance?.toJson(),
  };
}

class BestCourier {
  String? name;
  String? pinImage;
  String? serviceCode;
  String? originCountry;
  bool? international;
  bool? domestic;
  bool? onDemand;
  String? status;
  List<PackageCategory>? packageCategories;

  BestCourier({
    this.name,
    this.pinImage,
    this.serviceCode,
    this.originCountry,
    this.international,
    this.domestic,
    this.onDemand,
    this.status,
    this.packageCategories,
  });

  factory BestCourier.fromJson(Map<String, dynamic> json) => BestCourier(
    name: json["name"],
    pinImage: json["pin_image"],
    serviceCode: json["service_code"],
    originCountry: json["origin_country"],
    international: json["international"],
    domestic: json["domestic"],
    onDemand: json["on_demand"],
    status: json["status"],
    packageCategories: json["package_categories"] == null ? [] : List<PackageCategory>.from(json["package_categories"]!.map((x) => PackageCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "pin_image": pinImage,
    "service_code": serviceCode,
    "origin_country": originCountry,
    "international": international,
    "domestic": domestic,
    "on_demand": onDemand,
    "status": status,
    "package_categories": packageCategories == null ? [] : List<dynamic>.from(packageCategories!.map((x) => x.toJson())),
  };
}

class PackageCategory {
  int? id;
  String? category;

  PackageCategory({
    this.id,
    this.category,
  });

  factory PackageCategory.fromJson(Map<String, dynamic> json) => PackageCategory(
    id: json["id"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
  };
}

class BestFitBox {
  String? name;
  String? descriptionImageUrl;
  int? height;
  int? width;
  int? length;
  int? maxWeight;

  BestFitBox({
    this.name,
    this.descriptionImageUrl,
    this.height,
    this.width,
    this.length,
    this.maxWeight,
  });

  factory BestFitBox.fromJson(Map<String, dynamic> json) => BestFitBox(
    name: json["name"],
    descriptionImageUrl: json["description_image_url"],
    height: json["height"],
    width: json["width"],
    length: json["length"],
    maxWeight: json["max_weight"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description_image_url": descriptionImageUrl,
    "height": height,
    "width": width,
    "length": length,
    "max_weight": maxWeight,
  };
}

class Validation {
  String? status;
  String? message;
  FromValidationData? data;

  Validation({
    this.status,
    this.message,
    this.data,
  });

  factory Validation.fromJson(Map<String, dynamic> json) => Validation(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : FromValidationData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class FromValidationData {
  int? addressCode;
  String? address;
  String? name;
  String? email;
  String? streetNo;
  String? street;
  String? phone;
  String? formattedAddress;
  String? country;
  String? countryCode;
  String? city;
  String? cityCode;
  String? state;
  String? stateCode;
  String? postalCode;
  double? latitude;
  double? longitude;

  FromValidationData({
    this.addressCode,
    this.address,
    this.name,
    this.email,
    this.streetNo,
    this.street,
    this.phone,
    this.formattedAddress,
    this.country,
    this.countryCode,
    this.city,
    this.cityCode,
    this.state,
    this.stateCode,
    this.postalCode,
    this.latitude,
    this.longitude,
  });

  factory FromValidationData.fromJson(Map<String, dynamic> json) => FromValidationData(
    addressCode: json["address_code"],
    address: json["address"],
    name: json["name"],
    email: json["email"],
    streetNo: json["street_no"],
    street: json["street"],
    phone: json["phone"],
    formattedAddress: json["formatted_address"],
    country: json["country"],
    countryCode: json["country_code"],
    city: json["city"],
    cityCode: json["city_code"],
    state: json["state"],
    stateCode: json["state_code"],
    postalCode: json["postal_code"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "address_code": addressCode,
    "address": address,
    "name": name,
    "email": email,
    "street_no": streetNo,
    "street": street,
    "phone": phone,
    "formatted_address": formattedAddress,
    "country": country,
    "country_code": countryCode,
    "city": city,
    "city_code": cityCode,
    "state": state,
    "state_code": stateCode,
    "postal_code": postalCode,
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Insurance {
  String? code;
  String? insurer;
  String? currency;
  double? insurePercentage;
  double? insureAmount;
  int? amount;
  String? policyCondition;

  Insurance({
    this.code,
    this.insurer,
    this.currency,
    this.insurePercentage,
    this.insureAmount,
    this.amount,
    this.policyCondition,
  });

  factory Insurance.fromJson(Map<String, dynamic> json) => Insurance(
    code: json["code"],
    insurer: json["insurer"],
    currency: json["currency"],
    insurePercentage: json["insure_percentage"]?.toDouble(),
    insureAmount: json["insure_amount"]?.toDouble(),
    amount: json["amount"],
    policyCondition: json["policy_condition"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "insurer": insurer,
    "currency": currency,
    "insure_percentage": insurePercentage,
    "insure_amount": insureAmount,
    "amount": amount,
    "policy_condition": policyCondition,
  };
}

class ShippingRate {
  String? requestToken;
  String? courierId;
  String? courierName;
  int? total;
  String? currency;
  String? deliveryEta;
  String? pickupEta;
  String? image;

  ShippingRate({
    this.requestToken,
    this.courierId,
    this.courierName,
    this.total,
    this.currency,
    this.deliveryEta,
    this.pickupEta,
    this.image,
  });

  factory ShippingRate.fromJson(Map<String, dynamic> json) => ShippingRate(
    requestToken: json["request_token"],
    courierId: json["courier_id"],
    courierName: json["courier_name"],
    total: json["total"],
    currency: json["currency"],
    deliveryEta: json["delivery_eta"],
    pickupEta: json["pickup_eta"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "request_token": requestToken,
    "courier_id": courierId,
    "courier_name": courierName,
    "total": total,
    "currency": currency,
    "delivery_eta": deliveryEta,
    "pickup_eta": pickupEta,
    "image": image,
  };
}
