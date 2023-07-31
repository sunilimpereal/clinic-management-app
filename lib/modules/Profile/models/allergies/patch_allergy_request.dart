// To parse this JSON data, do
//
//     final patchAllergyRequest = patchAllergyRequestFromJson(jsonString);

import 'dart:convert';

PatchAllergyRequest patchAllergyRequestFromJson(String str) => PatchAllergyRequest.fromJson(json.decode(str));

String patchAllergyRequestToJson(PatchAllergyRequest data) => json.encode(data.toJson());

class PatchAllergyRequest {
  String patientId;
  List<String> medicineAllergies;
  List<String> foodAllergies;
  List<String> petAllergies;
  String other;

  PatchAllergyRequest({
    required this.patientId,
    required this.medicineAllergies,
    required this.foodAllergies,
    required this.petAllergies,
    required this.other,
  });

  factory PatchAllergyRequest.fromJson(Map<String, dynamic> json) => PatchAllergyRequest(
        patientId: json["patientId"],
        medicineAllergies: List<String>.from(json["medicineAllergies"].map((x) => x)),
        foodAllergies: List<String>.from(json["foodAllergies"].map((x) => x)),
        petAllergies: List<String>.from(json["petAllergies"].map((x) => x)),
        other: json["other"],
      );

  Map<String, dynamic> toJson() => {
        "patientId": patientId,
        "medicineAllergies": List<dynamic>.from(medicineAllergies.map((x) => x)),
        "foodAllergies": List<dynamic>.from(foodAllergies.map((x) => x)),
        "petAllergies": List<dynamic>.from(petAllergies.map((x) => x)),
        "other": other,
      };
}
