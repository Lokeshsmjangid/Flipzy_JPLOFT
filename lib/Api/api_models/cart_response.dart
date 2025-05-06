// To parse this JSON data, do
//
//     final cartResponse = cartResponseFromJson(jsonString);

import 'dart:convert';

CartResponse cartResponseFromJson(String str) => CartResponse.fromJson(json.decode(str));

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse {
  String? message;
  bool? status;
  CartData? data;

  CartResponse({
    this.message,
    this.status,
    this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? null : CartData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data?.toJson(),
  };
}

class CartData {
  List<CartProduct>? products;
  int? totalItemsInCart;
  int? discount;
  int? deliveryCharges;
  int? totalAmount;

  CartData({
    this.products,
    this.totalItemsInCart,
    this.discount,
    this.deliveryCharges,
    this.totalAmount,
  });

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
    products: json["products"] == null ? [] : List<CartProduct>.from(json["products"]!.map((x) => CartProduct.fromJson(x))),
    totalItemsInCart: json["total items in cart"],
    discount: json["discount"],
    deliveryCharges: json["delivery charges"],
    totalAmount: json["total amount"],
  );

  Map<String, dynamic> toJson() => {
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "total items in cart": totalItemsInCart,
    "discount": discount,
    "delivery charges": deliveryCharges,
    "total amount": totalAmount,
  };
}

class CartProduct {
  String? sellerId;
  String? productId;
  int? quantity;
  int? price;
  Variations? variations;
  List<String>? images;
  String? productName;
  bool? isfavIcon;
  bool? bestseller;
  bool? featured;
  String? id;

  CartProduct({
    this.sellerId,
    this.productId,
    this.quantity,
    this.price,
    this.variations,
    this.images,
    this.productName,
    this.isfavIcon,
    this.bestseller,
    this.featured,
    this.id,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
    sellerId: json["sellerId"],
    productId: json["productId"],
    quantity: json["quantity"],
    price: json["price"],
    variations: json["variations"] == null ? null : Variations.fromJson(json["variations"]),
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    productName: json["productName"],
    isfavIcon: json["isfavIcon"],
    bestseller: json["bestseller"],
    featured: json["featured"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "sellerId": sellerId,
    "productId": productId,
    "quantity": quantity,
    "price": price,
    "variations": variations?.toJson(),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "productName": productName,
    "isfavIcon": isfavIcon,
    "bestseller": bestseller,
    "featured": featured,
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
