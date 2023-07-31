// To parse this JSON data, do
//
//     final PatientChangePassRequestModel = PatientChangePassRequestModelFromJson(jsonString);

import 'dart:convert';

PatientChangePassRequestModel patientChangePassRequestModelFromJson(String str) => PatientChangePassRequestModel.fromJson(json.decode(str));

String patientChangePassRequestModelToJson(PatientChangePassRequestModel data) => json.encode(data.toJson());

class PatientChangePassRequestModel {
  String oldPassword;
  String password;

  PatientChangePassRequestModel({
    required this.oldPassword,
    required this.password,
  });

  factory PatientChangePassRequestModel.fromJson(Map<String, dynamic> json) => PatientChangePassRequestModel(
        oldPassword: json["oldPassword"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "oldPassword": oldPassword,
        "password": password,
      };
}
