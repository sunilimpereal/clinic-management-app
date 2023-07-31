// To parse this JSON data, do
//
//     final refreshLoginResponse = refreshLoginResponseFromJson(jsonString);

import 'dart:convert';

RefreshLoginResponse refreshLoginResponseFromJson(String str) =>
    RefreshLoginResponse.fromJson(json.decode(str));

String refreshLoginResponseToJson(RefreshLoginResponse data) =>
    json.encode(data.toJson());

class RefreshLoginResponse {
  Data data;

  RefreshLoginResponse({
    required this.data,
  });

  factory RefreshLoginResponse.fromJson(Map<String, dynamic> json) =>
      RefreshLoginResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  String authToken;
  String refreshToken;

  Data({
    required this.authToken,
    required this.refreshToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        authToken: json["authToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "authToken": authToken,
        "refreshToken": refreshToken,
      };
}
