import 'dart:convert';

RefreshRequestModel refreshRequestModelFromJson(String str) =>
    RefreshRequestModel.fromJson(json.decode(str));

String refreshRequestModelToJson(RefreshRequestModel data) =>
    json.encode(data.toJson());

class RefreshRequestModel {
  RefreshRequestModel({
    required this.refreshToken,
    required this.accessToken,
  });

  String refreshToken;
  String accessToken;

  factory RefreshRequestModel.fromJson(Map<String, dynamic> json) =>
      RefreshRequestModel(
        refreshToken: json["refreshToken"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "refreshToken": refreshToken,
        "accessToken": accessToken,
      };
}
