// To parse this JSON data, do
//
//     final postVaccineRequest = postVaccineRequestFromJson(jsonString);

import 'dart:convert';

List<PostVaccineRequest> postVaccineRequestFromJson(String str) =>
    List<PostVaccineRequest>.from(json.decode(str).map((x) => PostVaccineRequest.fromJson(x)));

String postVaccineRequestToJson(List<PostVaccineRequest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostVaccineRequest {
  String patientId;
  dynamic clinicId;
  String vaccinationName;
  DateTime vaccinationDate;
  String url;

  PostVaccineRequest({
    required this.patientId,
    this.clinicId,
    required this.vaccinationName,
    required this.vaccinationDate,
    required this.url,
  });

  factory PostVaccineRequest.fromJson(Map<String, dynamic> json) => PostVaccineRequest(
        patientId: json["patientId"],
        clinicId: json["clinicId"],
        vaccinationName: json["vaccinationName"],
        vaccinationDate: DateTime.parse(json["vaccinationDate"]),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "patientId": patientId,
        "clinicId": clinicId,
        "vaccinationName": vaccinationName,
        "vaccinationDate": vaccinationDate.toIso8601String(),
        "url": url,
      };
}
