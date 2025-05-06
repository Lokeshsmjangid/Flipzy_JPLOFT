class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? guestId;
  String? userType;
  String? password;
  int? mobileNumber;
  String? status;
  bool? businessCheck;
  String? ifsc;
  List<dynamic>? roomId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? otp;
  String? location;
  String? profileImage;
  String? accountHolderName;
  String? accountNumber;
  String? bankName;
  String? businessName;
  String? rcNumber;
  String? storeDescription;
  dynamic profilePercentage;

  UserModel({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.guestId,
    this.userType,
    this.password,
    this.mobileNumber,
    this.status,
    this.businessCheck,
    this.ifsc,
    this.roomId,
    this.createdAt,
    this.updatedAt,
    this.otp,
    this.location,
    this.profileImage,
    this.accountHolderName,
    this.accountNumber,
    this.bankName,
    this.businessName,
    this.rcNumber,
    this.storeDescription,
    this.profilePercentage,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["_id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    guestId: json["guestId"],
    userType: json["userType"],
    password: json["password"],
    mobileNumber: json["mobileNumber"],
    status: json["status"],
    businessCheck: json["businessCheck"],
    ifsc: json["ifsc"],
    roomId: json["room_id"] == null ? [] : List<dynamic>.from(json["room_id"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    otp: json["otp"],
    location: json["location"],
    profileImage: json["profileImage"],
    accountHolderName: json["accountHolderName"],
    accountNumber: json["accountNumber"],
    bankName: json["bankName"],
    businessName: json["businessName"],
    rcNumber: json["rcNumber"],
    storeDescription: json["storeDescription"],
    profilePercentage: json["profilePercentage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "guestId": guestId,
    "userType": userType,
    "password": password,
    "mobileNumber": mobileNumber,
    "status": status,
    "businessCheck": businessCheck,
    "ifsc": ifsc,
    "room_id": roomId == null ? [] : List<dynamic>.from(roomId!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "otp": otp,
    "location": location,
    "profileImage": profileImage,
    "accountHolderName": accountHolderName,
    "accountNumber": accountNumber,
    "bankName": bankName,
    "businessName": businessName,
    "rcNumber": rcNumber,
    "storeDescription": storeDescription,
    "profilePercentage": profilePercentage,
  };
}