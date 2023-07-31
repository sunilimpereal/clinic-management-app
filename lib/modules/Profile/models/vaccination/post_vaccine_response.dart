// To parse this JSON data, do
//
//     final postVaccineResponse = postVaccineResponseFromJson(jsonString);

import 'dart:convert';

PostVaccineResponse postVaccineResponseFromJson(String str) => PostVaccineResponse.fromJson(json.decode(str));

String postVaccineResponseToJson(PostVaccineResponse data) => json.encode(data.toJson());

class PostVaccineResponse {
  String message;
  bool success;
  List<Datum> data;

  PostVaccineResponse({
    required this.message,
    required this.success,
    required this.data,
  });

  factory PostVaccineResponse.fromJson(Map<String, dynamic> json) => PostVaccineResponse(
        message: json["message"],
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String patientId;
  dynamic clinicId;
  String vaccinationName;
  DateTime vaccinationDate;
  String url;

  Datum({
    required this.id,
    required this.patientId,
    this.clinicId,
    required this.vaccinationName,
    required this.vaccinationDate,
    required this.url,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        patientId: json["patientId"],
        clinicId: json["clinicId"],
        vaccinationName: json["vaccinationName"],
        vaccinationDate: DateTime.parse(json["vaccinationDate"]),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patientId": patientId,
        "clinicId": clinicId,
        "vaccinationName": vaccinationName,
        "vaccinationDate": vaccinationDate.toIso8601String(),
        "url": url,
      };
}
