// To parse this JSON data, do
//
//     final PatientUpdateResponseModel = PatientUpdateResponseModelFromJson(jsonString);

import 'dart:convert';

PatientUpdateResponseModel patientUpdateResponseModelFromJson(String str) {
  print("str from response=>>>  $str");
  return PatientUpdateResponseModel.fromJson(json.decode(str));
}

String patientUpdateResponseModelToJson(PatientUpdateResponseModel data) =>
    json.encode(data.toJson());

class PatientUpdateResponseModel {
  int status;
  Data? data;

  PatientUpdateResponseModel({
    required this.status,
    this.data,
  });

  factory PatientUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    print("from response model =>>> ${json["data"]}");
    return PatientUpdateResponseModel(
      status: json["status"],
      data: Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  String id;
  String name;
  String email;
  String phoneNumber;
  String address;
  String city;
  String state;
  String country;
  String pinCode;
  DateTime dateOfBirth;
  String gender;
  bool isDeactive;
  bool isMfaActive;
  String photo;
  DateTime createdAt;
  DateTime updatedAt;
  List<Role> roles;
  String qualification;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.pinCode,
    required this.dateOfBirth,
    required this.gender,
    required this.isDeactive,
    required this.isMfaActive,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
    required this.roles,
    required this.qualification,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    print("from fromjson response model =>> $json ${json['name']}");
    return Data(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      address: json["address"],
      city: json["city"],
      state: json["state"],
      country: json["country"],
      pinCode: json["pinCode"],
      dateOfBirth: DateTime.parse(json["dateOfBirth"]),
      gender: json["gender"],
      isDeactive: json["isDeactive"],
      isMfaActive: json["isMfaActive"],
      photo: json["photo"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
      qualification: json["qualification"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "pinCode": pinCode,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "gender": gender,
        "isDeactive": isDeactive,
        "isMfaActive": isMfaActive,
        "photo": photo,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        "qualification": qualification,
      };
}

class Role {
  String id;
  String userId;
  String role;

  Role({
    required this.id,
    required this.userId,
    required this.role,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        userId: json["userId"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "role": role,
      };
}
