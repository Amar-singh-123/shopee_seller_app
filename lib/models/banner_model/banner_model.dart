import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  String? bannerId;
  String? bannerImage;
  String? bannerDiscount;
  String? couponCode;
  String? link;
  bool? isEnable;

  BannerModel({
    this.bannerId,
    this.bannerImage,
    this.bannerDiscount,
    this.couponCode,
    this.link,
    this.isEnable,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    bannerId: json["bannerId"],
    bannerImage: json["bannerImage"],
    bannerDiscount: json["bannerDiscount"],
    couponCode: json["couponCode"],
    link: json["link"],
    isEnable: json["isEnable"],
  );

  Map<String, dynamic> toJson() => {
    "bannerId": bannerId,
    "bannerImage": bannerImage,
    "bannerDiscount": bannerDiscount,
    "couponCode": couponCode,
    "link": link,
    "isEnable": isEnable,
  };
}
