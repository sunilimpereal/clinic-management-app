// To parse this JSON data, do
//
//     final loginRequestModel = loginRequestModelFromJson(jsonString);

import 'dart:convert';

SocialLoginRequestModel socialLoginRequestModelFromJson(String str) => SocialLoginRequestModel.fromJson(json.decode(str));

String socialLoginRequestModelToJson(SocialLoginRequestModel data) => json.encode(data.toJson());

class SocialLoginRequestModel {
  SocialLoginRequestModel();

 

  factory SocialLoginRequestModel.fromJson(Map<String, dynamic> json) => SocialLoginRequestModel(
      );

  Map<String, dynamic> toJson() => {
      };
}
