// To parse this JSON data, do
//
//     final userPutRequest = userPutRequestFromJson(jsonString);

import 'dart:convert';

UserPutRequest userPutRequestFromJson(String str) => UserPutRequest.fromJson(json.decode(str));

String userPutRequestToJson(UserPutRequest data) => json.encode(data.toJson());

class UserPutRequest {
  String? name;

  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pinCode;
  DateTime? dateOfBirth;
  String? gender;

  UserPutRequest({
    this.name,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.country,
    this.pinCode,
    this.dateOfBirth,
    this.gender,
  });

  factory UserPutRequest.fromJson(Map<String, dynamic> json) => UserPutRequest(
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pinCode: json["pinCode"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phoneNumber": phoneNumber,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "pinCode": pinCode,
        "dateOfBirth":
            dateOfBirth?.toIso8601String().endsWith("Z") ?? false ? "${dateOfBirth?.toIso8601String()}" : "${dateOfBirth?.toIso8601String()}Z",
        "gender": gender,
      };
}
