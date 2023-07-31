// To parse this JSON data, do
//
//     final getPatientResponse = getPatientResponseFromJson(jsonString);

import 'dart:convert';

GetPatientResponse getPatientResponseFromJson(String str) =>
    GetPatientResponse.fromJson(json.decode(str));

String getPatientResponseToJson(GetPatientResponse data) =>
    json.encode(data.toJson());

class GetPatientResponse {
  String message;
  bool success;
  PatientData data;
  dynamic error;

  GetPatientResponse({
    required this.message,
    required this.success,
    required this.data,
    this.error,
  });

  factory GetPatientResponse.fromJson(Map<String, dynamic> json) =>
      GetPatientResponse(
        message: json["message"],
        success: json["success"],
        data: PatientData.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data.toJson(),
        "error": error,
      };
}

class PatientData {
  UserPatientData userPatientData;
  Patient patient;
  Allergies? allergies;

  PatientData({
    required this.userPatientData,
    required this.patient,
    required this.allergies,
  });

  factory PatientData.fromJson(Map<String, dynamic> json) => PatientData(
        userPatientData: UserPatientData.fromJson(json["userData"]),
        patient: Patient.fromJson(json["patient"]),
        allergies: json["allergies"] != null
            ? Allergies.fromJson(json["allergies"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "userPatientData": userPatientData.toJson(),
        "patient": patient.toJson(),
        "allergies": allergies?.toJson(),
      };
}

class Allergies {
  String? id;
  String patientId;
  List<String> medicineAllergies;
  List<String> foodAllergies;
  List<String> petAllergies;
  String other;

  Allergies({
    this.id,
    required this.patientId,
    required this.medicineAllergies,
    required this.foodAllergies,
    required this.petAllergies,
    required this.other,
  });

  factory Allergies.fromJson(Map<String, dynamic> json) => Allergies(
        id: json["id"],
        patientId: json["patientId"],
        medicineAllergies:
            List<String>.from(json["medicineAllergies"].map((x) => x)),
        foodAllergies: List<String>.from(json["foodAllergies"].map((x) => x)),
        petAllergies: List<String>.from(json["petAllergies"].map((x) => x)),
        other: json["other"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patientId": patientId,
        "medicineAllergies":
            List<dynamic>.from(medicineAllergies.map((x) => x)),
        "foodAllergies": List<dynamic>.from(foodAllergies.map((x) => x)),
        "petAllergies": List<dynamic>.from(petAllergies.map((x) => x)),
        "other": other,
      };
}

class Patient {
  String id;
  String? gender;
  String? maritalStatus;
  DateTime createdAt;
  bool isArchived;
  int? height;
  int? weight;
  DateTime updatedAt;
  String userId;

  Patient({
    required this.id,
    required this.gender,
    required this.maritalStatus,
    required this.createdAt,
    required this.isArchived,
    required this.updatedAt,
    required this.userId,
    required this.height,
    required this.weight,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["id"],
        gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        isArchived: json["isArchived"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
        height: json["height"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gender": gender,
        "maritalStatus": maritalStatus,
        "createdAt": createdAt.toIso8601String(),
        "isArchived": isArchived,
        "updatedAt": updatedAt.toIso8601String(),
        "userId": userId,
      };
}

class UserPatientData {
  String id;
  String name;
  String email;
  String? phoneNumber;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  dynamic secondaryPhoneNumber;
  String? pinCode;
  DateTime? dateOfBirth;
  String? gender;
  bool isDeactive;
  bool isMfaActive;
  String? photo;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? qualification;
  String lastLoggedIn;
  String passwordLastUpdated;

  UserPatientData(
      {required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.addressLine1,
      required this.addressLine2,
      required this.city,
      required this.state,
      required this.country,
      this.secondaryPhoneNumber,
      required this.pinCode,
      required this.dateOfBirth,
      required this.gender,
      required this.isDeactive,
      required this.isMfaActive,
      required this.photo,
      required this.createdAt,
      required this.updatedAt,
      required this.qualification,
      required this.lastLoggedIn,
      required this.passwordLastUpdated});

  factory UserPatientData.fromJson(Map<String, dynamic> json) {
    String addressLine1 = '';
    String addressLine2 = '';
    RegExp spaceRegex = RegExp(r'\s', multiLine: true);
    if (json["address"] != null){
      List<String> addressParts = json["address"]?.split(spaceRegex);
    if (addressParts.length == 1) {
      addressLine1 = json["address"];
    } else {
      addressLine1 = addressParts[0];
      addressLine2 = addressParts.sublist(1).join(' ');
    }}
    return UserPatientData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        addressLine1: addressLine1,
        addressLine2: addressLine2,
        city: json["city"],
        state: json["state"],
        country: json["country"],
        secondaryPhoneNumber: json["secondaryPhoneNumber"],
        pinCode: json["pinCode"],
        dateOfBirth: json["dateOfBirth"] != null
            ? DateTime.tryParse(json["dateOfBirth"])
            : null,
        gender: json["gender"],
        isDeactive: json["isDeactive"],
        isMfaActive: json["isMfaActive"],
        photo: json["photo"],
        createdAt: DateTime.tryParse(json["createdAt"]),
        updatedAt: DateTime.tryParse(json["updatedAt"]),
        qualification: json["qualification"],
        lastLoggedIn: json["lastLoggedIn"],
        passwordLastUpdated: json["passwordLastUpdated"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "address": '$addressLine1 $addressLine2'.trim(),
        "city": city,
        "state": state,
        "country": country,
        "secondaryPhoneNumber": secondaryPhoneNumber,
        "pinCode": pinCode,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "gender": gender,
        "isDeactive": isDeactive,
        "isMfaActive": isMfaActive,
        "photo": photo,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "qualification": qualification,
        "lastLoggedIn": lastLoggedIn,
        "passwordLastUpdated": passwordLastUpdated
      };
}
