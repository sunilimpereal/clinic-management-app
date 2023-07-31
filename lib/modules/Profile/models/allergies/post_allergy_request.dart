// To parse this JSON data, do
//
//     final postAllergyRequest = postAllergyRequestFromJson(jsonString);

import 'dart:convert';

PostAllergyRequest postAllergyRequestFromJson(String str) => PostAllergyRequest.fromJson(json.decode(str));

String postAllergyRequestToJson(PostAllergyRequest data) => json.encode(data.toJson());

class PostAllergyRequest {
  String patientId;
  List<String> medicineAllergies;
  List<String> foodAllergies;
  List<String> petAllergies;
  String other;

  PostAllergyRequest({
    required this.patientId,
    required this.medicineAllergies,
    required this.foodAllergies,
    required this.petAllergies,
    required this.other,
  });

  factory PostAllergyRequest.fromJson(Map<String, dynamic> json) => PostAllergyRequest(
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
