// To parse this JSON data, do
//
//     final geoLocationDoctorsResponse = geoLocationDoctorsResponseFromJson(jsonString);

import 'dart:convert';

GeoLocationDoctorsResponse geoLocationDoctorsResponseFromJson(String str) =>
    GeoLocationDoctorsResponse.fromJson(json.decode(str));

String geoLocationDoctorsResponseToJson(GeoLocationDoctorsResponse data) =>
    json.encode(data.toJson());

class GeoLocationDoctorsResponse {
  int status;
  List<AvailableDoctor> data;

  GeoLocationDoctorsResponse({
    required this.status,
    required this.data,
  });

  factory GeoLocationDoctorsResponse.fromJson(Map<String, dynamic> json) =>
      GeoLocationDoctorsResponse(
        status: json["status"],
        data: List<AvailableDoctor>.from(
            json["data"].map((x) => AvailableDoctor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AvailableDoctor {
  Doctor doctor;
  UserData userData;
  DoctorClinic doctorClinic;
  Specialisation specialisation;

  AvailableDoctor({
    required this.doctor,
    required this.userData,
    required this.doctorClinic,
    required this.specialisation,
  });

  factory AvailableDoctor.fromJson(Map<String, dynamic> json) =>
      AvailableDoctor(
        doctor: Doctor.fromJson(json["doctor"]),
        userData: UserData.fromJson(json["userData"]),
        doctorClinic: DoctorClinic.fromJson(json["clinic"]),
        specialisation: Specialisation.fromJson(json["specialisation"]),
      );

  Map<String, dynamic> toJson() => {
        "doctor": doctor.toJson(),
        "userData": userData.toJson(),
        "specialisation": specialisation.toJson(),
        "clinic": doctorClinic.toJson(),
      };
}
class DoctorClinic {
  String name;
  String logo;
  String geoLocation;

  DoctorClinic({
    required this.name,
    required this.logo,
    required this.geoLocation,
  });

  factory DoctorClinic.fromJson(Map<String, dynamic> json) => DoctorClinic(
        name: json["name"],
        logo: json["logo"],
        geoLocation: json["geoLocation"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "logo": logo,
        "geoLocation": geoLocation,
      };
}


class Doctor {
  String id;
  String userId;
  String clinicId;
  String qualification;
  String licenseNumber;
  String onlineFees;
  String inPersonFees;
  DateTime createdAt;
  DateTime updatedAt;
  String description;
  String? specialisationId;

  Doctor({
    required this.id,
    required this.userId,
    required this.clinicId,
    required this.qualification,
    required this.licenseNumber,
    required this.onlineFees,
    required this.inPersonFees,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.specialisationId,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        userId: json["userId"],
        clinicId: json["clinicId"],
        qualification: json["qualification"],
        licenseNumber: json["licenseNumber"],
        onlineFees: json["onlineFees"],
        inPersonFees: json["inPersonFees"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        description: json["description"],
        specialisationId: json["specialisationId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "clinicId": clinicId,
        "qualification": qualification,
        "licenseNumber": licenseNumber,
        "onlineFees": onlineFees,
        "inPersonFees": inPersonFees,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "description": description,
        "specialisationId": specialisationId,
      };
}

class Specialisation {
  String id;
  String specialisation;

  Specialisation({required this.id, required this.specialisation});

  factory Specialisation.fromJson(Map<String, dynamic> json) =>
      Specialisation(id: json["id"], specialisation: json["specialisation"]);

  Map<String, dynamic> toJson() => {"id": id, "specialisation": specialisation};
}

class UserData {
  String id;
  String name;
  String email;
  String phoneNumber;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pinCode;
  String? gender;
  String jatyaId;
  bool isDeactive;
  bool isMfaActive;
  String? photo;
  DateTime createdAt;
  String? updatedAt;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.pinCode,
    required this.gender,
    required this.jatyaId,
    required this.isDeactive,
    required this.isMfaActive,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pinCode: json["pinCode"],
        gender: json["gender"],
        jatyaId: json["jatyaId"],
        isDeactive: json["isDeactive"],
        isMfaActive: json["isMfaActive"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] ?? "",
      );

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
        "gender": gender,
        "jatyaId": jatyaId,
        "isDeactive": isDeactive,
        "isMfaActive": isMfaActive,
        "photo": photo,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt,
      };
}
