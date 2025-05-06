// To parse this JSON data, do
//
//     final homeModelResponse = homeModelResponseFromJson(jsonString);

import 'dart:convert';

import 'category_model.dart';

HomeModelResponse homeModelResponseFromJson(String str) => HomeModelResponse.fromJson(json.decode(str));

String homeModelResponseToJson(HomeModelResponse data) => json.encode(data.toJson());

class HomeModelResponse {
  String? message;
  bool? status;
  Data? data;

  HomeModelResponse({
    this.message,
    this.status,
    this.data,
  });

  factory HomeModelResponse.fromJson(Map<String, dynamic> json) => HomeModelResponse(
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
  List<Product>? featuredProducts;
  List<Product>? productList;
  List<Category>? categoryList;

  Data({
    this.featuredProducts,
    this.productList,
    this.categoryList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    featuredProducts: json["featuredProducts"] == null ? [] : List<Product>.from(json["featuredProducts"]!.map((x) => Product.fromJson(x))),
    productList: json["ProductList"] == null ? [] : List<Product>.from(json["ProductList"]!.map((x) => Product.fromJson(x))),
    categoryList: json["categoryList"] == null ? [] : List<Category>.from(json["categoryList"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "featuredProducts": featuredProducts == null ? [] : List<dynamic>.from(featuredProducts!.map((x) => x.toJson())),
    "ProductList": productList == null ? [] : List<dynamic>.from(productList!.map((x) => x.toJson())),
    "categoryList": categoryList == null ? [] : List<dynamic>.from(categoryList!.map((x) => x.toJson())),
  };
}

class Product {
  bool? favoriteIcon;
  int? deliveryCharge;
  int? discount;
  List<String>? productImages;
  String? userType;
  String? id;
  String? userId;
  String? productId;
  String? productName;
  String? brandName;
  String? category;
  String? price;
  dynamic commission;
  dynamic amountAfterDeduction;
  String? productDescription;
  String? productWeight;
  String? productDimentions;
  bool? localPickUp;
  bool? deliveryFee;
  bool? bestseller;
  bool? featured;
  bool? isReturnAvailable;
  int? availableProduct;
  String? deliveryCity;
  int? deliveryRate;
  String? sellBeyondCityLimits;
  int? stockQuantity;
  String? stock;
  List<BoostProduct>? boostProduct;
  List<dynamic>? declineReason;
  List<dynamic>? refund;
  String? sellerId;
  List<FavoriteIcon>? favoriteIcons;
  dynamic rating;
  List<ShippingCharge>? shippingCharges;

  Product({
    this.favoriteIcon,
    this.deliveryCharge,
    this.discount,
    this.productImages,
    this.userType,
    this.id,
    this.userId,
    this.productId,
    this.productName,
    this.brandName,
    this.category,
    this.price,
    this.commission,
    this.amountAfterDeduction,
    this.productDescription,
    this.productWeight,
    this.productDimentions,
    this.localPickUp,
    this.isReturnAvailable,
    this.deliveryFee,
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
    this.sellerId,
    this.favoriteIcons,
    this.rating,
    this.shippingCharges,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    favoriteIcon: json["isfavIcon"],
    deliveryCharge: json["deliveryCharge"],
    discount: json["discount"],
    productImages: json["productImages"] == null ? [] : List<String>.from(json["productImages"]!.map((x) => x)),
    userType: json["userType"],
    id: json["_id"],
    userId: json["userId"],
    productId: json["productId"],
    productName: json["productName"],
    brandName: json["brandName"],
    category: json["category"],
    price: json["price"],
    commission: json["commission"],
    amountAfterDeduction: json["amountAfterDeduction"],
    productDescription: json["productDescription"],
    productWeight: json["productWeight"],
    productDimentions: json["productDimentions"],
    localPickUp: json["localPickUp"],
    isReturnAvailable: json["isReturnAvailable"],
    deliveryFee: json["deliveryFee"],
    bestseller: json["bestseller"],
    featured: json["featured"],
    availableProduct: json["availableProduct"],
    deliveryCity: json["deliveryCity"],
    deliveryRate: json["deliveryRate"],
    sellBeyondCityLimits: json["sellBeyondCityLimits"],
    stockQuantity: json["stockQuantity"],
    stock: json["stock"],
    boostProduct: json["boostProduct"] == null ? [] : List<BoostProduct>.from(json["boostProduct"]!.map((x) => BoostProduct.fromJson(x))),
    declineReason: json["declineReason"] == null ? [] : List<dynamic>.from(json["declineReason"]!.map((x) => x)),
    refund: json["refund"] == null ? [] : List<dynamic>.from(json["refund"]!.map((x) => x)),
    sellerId: json["sellerId"],
    favoriteIcons: json["favoriteIcons"] == null ? [] : List<FavoriteIcon>.from(json["favoriteIcons"]!.map((x) => FavoriteIcon.fromJson(x))),
    rating: json["rating"],
    shippingCharges: json["shippingCharges"] == null ? [] : List<ShippingCharge>.from(json["shippingCharges"]!.map((x) => ShippingCharge.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isfavIcon": favoriteIcon,
    "deliveryCharge": deliveryCharge,
    "discount": discount,
    "productImages": productImages == null ? [] : List<dynamic>.from(productImages!.map((x) => x)),
    "userType": userType,
    "_id": id,
    "userId": userId,
    "productId": productId,
    "productName": productName,
    "brandName": brandName,
    "category": category,
    "price": price,
    "commission": commission,
    "amountAfterDeduction": amountAfterDeduction,
    "productDescription": productDescription,
    "productWeight": productWeight,
    "productDimentions": productDimentions,
    "localPickUp": localPickUp,
    "isReturnAvailable": isReturnAvailable,
    "deliveryFee": deliveryFee,
    "bestseller": bestseller,
    "featured": featured,
    "availableProduct": availableProduct,
    "deliveryCity": deliveryCity,
    "deliveryRate": deliveryRate,
    "sellBeyondCityLimits": sellBeyondCityLimits,
    "stockQuantity": stockQuantity,
    "stock": stock,
    "boostProduct": boostProduct == null ? [] : List<dynamic>.from(boostProduct!.map((x) => x.toJson())),
    "declineReason": declineReason == null ? [] : List<dynamic>.from(declineReason!.map((x) => x)),
    "refund": refund == null ? [] : List<dynamic>.from(refund!.map((x) => x)),
    "sellerId": sellerId,
    "favoriteIcons": favoriteIcons == null ? [] : List<dynamic>.from(favoriteIcons!.map((x) => x.toJson())),
    "rating": rating,
    "shippingCharges": shippingCharges == null ? [] : List<dynamic>.from(shippingCharges!.map((x) => x.toJson())),
  };
}

class FavoriteIcon {
  String? userId;
  bool? isFavorite;

  FavoriteIcon({
    this.userId,
    this.isFavorite,
  });

  factory FavoriteIcon.fromJson(Map<String, dynamic> json) => FavoriteIcon(
    userId: json["userId"],
    isFavorite: json["isFavorite"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "isFavorite": isFavorite,
  };
}

class BoostProduct {
  String? boostTime;
  int? boostPrice;
  String? status;
  DateTime? boostStartDate;
  String? id;

  BoostProduct({
    this.boostTime,
    this.boostPrice,
    this.status,
    this.boostStartDate,
    this.id,
  });

  factory BoostProduct.fromJson(Map<String, dynamic> json) => BoostProduct(
    boostTime: json["boostTime"],
    boostPrice: json["boostPrice"],
    status: json["status"],
    boostStartDate: json["boostStartDate"] == null ? null : DateTime.parse(json["boostStartDate"]),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "boostTime": boostTime,
    "boostPrice": boostPrice,
    "status": status,
    "boostStartDate": boostStartDate?.toIso8601String(),
    "_id": id,
  };
}

class ShippingCharge {
  String? city;
  int? rate;
  String? id;

  ShippingCharge({
    this.city,
    this.rate,
    this.id,
  });

  factory ShippingCharge.fromJson(Map<String, dynamic> json) => ShippingCharge(
    city: json["city"],
    rate: json["rate"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "rate": rate,
    "_id": id,
  };
}
