// To parse this JSON data, do
//
//     final patientPatchRequest = patientPatchRequestFromJson(jsonString);

import 'dart:convert';

PatientPatchRequest patientPatchRequestFromJson(String str) => PatientPatchRequest.fromJson(json.decode(str));

String patientPatchRequestToJson(PatientPatchRequest data) => json.encode(data.toJson());

class PatientPatchRequest {
  String? maritalStatus;
  String? userId;
  String? clinicId;
  bool? isArchived;
  int? height;
  int? weight;
  String? category;

  PatientPatchRequest({
    this.maritalStatus,
    this.userId,
    this.clinicId,
    this.isArchived,
    this.height,
    this.weight,
    this.category,
  });

  factory PatientPatchRequest.fromJson(Map<String, dynamic> json) => PatientPatchRequest(
        maritalStatus: json["maritalStatus"],
        userId: json["userId"],
        clinicId: json["clinicId"],
        isArchived: json["isArchived"],
        height: json["height"],
        weight: json["weight"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "maritalStatus": maritalStatus,
        // "userId": userId,
        // "clinicId": clinicId,
        // "isArchived": isArchived,
        "height": height,
        "weight": weight,
        // "category": category,
      };
}
