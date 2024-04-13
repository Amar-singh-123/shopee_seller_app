import 'dart:convert';

UserModel UserModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());



class UserModel {
  String? uId;
  String? userName;
  String? userPassword;
  String? userEmail;
  String? userGender;
  String? userContact;
  String? userImage;
  String? userAddress;
  String? userPinCode;

  UserModel({
    this.uId,
    this.userName,
    this.userEmail,
    this.userPassword,
    this.userGender,
    this.userContact,
    this.userImage,
    this.userAddress,
    this.userPinCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uId: json["uId"],
    userName: json["userName"],
    userEmail: json["userEmail"],
    userPassword: json["userPassword"],
    userGender: json["userGender"],
    userContact: json["userContact"],
    userImage: json["userImage"],
    userAddress: json["userAddress"],
    userPinCode: json["userPinCode"],
  );

  Map<String, dynamic> toJson() => {
    "uId": uId,
    "userName": userName,
    "userEmail": userEmail,
    "userPassword": userPassword ,
    "userGender": userGender,
    "userContact": userContact,
    "userImage": userImage,
    "userAddress": userAddress,
    "userPinCode": userPinCode,
  };
}