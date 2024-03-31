// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String? id;
  String? name;
  String? email;
  String? address;
  int? age;
  String?imageUrl;
  String? gender;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.address,
    this.age,
    this.imageUrl,
    this.gender,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    address: json["address"],
    age: json["age"],
    imageUrl: json["imageUrl"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "address": address,
    "age": age,
    "imageUrl":imageUrl,
    "gender": gender,
  };
}
