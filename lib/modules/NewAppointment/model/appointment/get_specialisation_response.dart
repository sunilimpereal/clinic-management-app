// To parse this JSON data, do
//
//     final getSpecialisationResponse = getSpecialisationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:clinic_app/modules/NewAppointment/model/doctors_via_location_response.dart';

GetSpecialisationResponse getSpecialisationResponseFromJson(String str) =>
    GetSpecialisationResponse.fromJson(json.decode(str));

String getSpecialisationResponseToJson(GetSpecialisationResponse data) =>
    json.encode(data.toJson());

class GetSpecialisationResponse {
  List<Specialisation> data;

  GetSpecialisationResponse({
    required this.data,
  });

  factory GetSpecialisationResponse.fromJson(Map<String, dynamic> json) =>
      GetSpecialisationResponse(
        data: List<Specialisation>.from(json["data"].map((x) => Specialisation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

// class Specialisation {
//   String id;
//   String specialisation;
//   DateTime createdAt;
//   DateTime updatedAt;

//   Specialisation({
//     required this.id,
//     required this.specialisation,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Specialisation.fromJson(Map<String, dynamic> json) => Specialisation(
//         id: json["id"],
//         specialisation: json["specialisation"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "specialisation": specialisation,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//       };
// }
