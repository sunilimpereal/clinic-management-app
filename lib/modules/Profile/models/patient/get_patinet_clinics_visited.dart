// To parse this JSON data, do
//
//     final patientClinicsVisit = patientClinicsVisitFromJson(jsonString);

import 'dart:convert';

List<PatientClinicsVisit> patientClinicsVisitFromJson(String str) =>
    List<PatientClinicsVisit>.from(
        json.decode(str).map((x) => PatientClinicsVisit.fromJson(x)));

String patientClinicsVisitToJson(List<PatientClinicsVisit> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatientClinicsVisit {
  String id;
  String name;
  String logo;
  String themeColor;
  String address;
  String city;
  String state;
  String country;
  String zipCode;
  String emailId;
  List<String> mobileNumbers;
  String description;
  String websiteUrl;
  String twitterHandle;
  String socialMediaHandle;
  String meta;
  bool isClosed;
  String geoLocation;
  String type;
  String? ownerId;
  String onboardedBy;
  int subscriptionId;
  String? termsAgreement;
  List<Speciality> specialities;

  PatientClinicsVisit({
    required this.id,
    required this.name,
    required this.logo,
    required this.themeColor,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.emailId,
    required this.mobileNumbers,
    required this.description,
    required this.websiteUrl,
    required this.twitterHandle,
    required this.socialMediaHandle,
    required this.meta,
    required this.isClosed,
    required this.geoLocation,
    required this.type,
    this.ownerId,
    required this.onboardedBy,
    required this.subscriptionId,
    this.termsAgreement,
    required this.specialities,
  });

  factory PatientClinicsVisit.fromJson(Map<String, dynamic> json) =>
      PatientClinicsVisit(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        themeColor: json["themeColor"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        zipCode: json["zipCode"],
        emailId: json["emailId"],
        mobileNumbers: List<String>.from(json["mobileNumbers"].map((x) => x)),
        description: json["description"],
        websiteUrl: json["websiteURL"],
        twitterHandle: json["twitterHandle"],
        socialMediaHandle: json["socialMediaHandle"],
        meta: json["meta"],
        isClosed: json["isClosed"],
        geoLocation: json["geoLocation"],
        type: json["type"],
        ownerId: json["ownerId"],
        onboardedBy: json["onboardedBy"],
        subscriptionId: json["subscriptionId"],
        termsAgreement: json["termsAgreement"],
        specialities: List<Speciality>.from(
            json["specialities"].map((x) => Speciality.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "themeColor": themeColor,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "zipCode": zipCode,
        "emailId": emailId,
        "mobileNumbers": List<dynamic>.from(mobileNumbers.map((x) => x)),
        "description": description,
        "websiteURL": websiteUrl,
        "twitterHandle": twitterHandle,
        "socialMediaHandle": socialMediaHandle,
        "meta": meta,
        "isClosed": isClosed,
        "geoLocation": geoLocation,
        "type": type,
        "ownerId": ownerId,
        "onboardedBy": onboardedBy,
        "subscriptionId": subscriptionId,
        "termsAgreement": termsAgreement,
        "specialities": List<dynamic>.from(specialities.map((x) => x.toJson())),
      };
}

class Speciality {
  String id;
  String speciality;
  DateTime createdAt;
  DateTime updatedAt;

  Speciality({
    required this.id,
    required this.speciality,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Speciality.fromJson(Map<String, dynamic> json) => Speciality(
        id: json["id"],
        speciality: json["speciality"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "speciality": speciality,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
