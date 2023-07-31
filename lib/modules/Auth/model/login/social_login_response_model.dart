import 'dart:convert';

import 'package:clinic_app/modules/Auth/model/login/login_response_model.dart';

SocialLoginResponseModel socialLoginResponseModelFromJson(String str) => SocialLoginResponseModel.fromJson(json.decode(str));

String socialLoginResponseModelToJson(SocialLoginResponseModel data) => json.encode(data.toJson());

class SocialLoginResponseModel {
  String authToken;
  String name;
  String id;
  String email;
  List<Role> roles;

  SocialLoginResponseModel({
    required this.authToken,
    required this.name,
    required this.id,
    required this.email,
    required this.roles,
  });

  factory SocialLoginResponseModel.fromJson(Map<String, dynamic> json) => SocialLoginResponseModel(
        authToken: json['authToken'],
        name: json['name'],
        id: json['id'],
        email: json['email'],
        roles: json['roles'] != null ? List<Role>.from(json["roles"].map((x) => Role.fromJson(x))) : [],
      );

  Map<String, dynamic> toJson() => {
        "authToken": authToken,
        "name": name,
        "id": id,
        "email": email,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
      };
}
