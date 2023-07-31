// To parse this JSON data, do
//
//     final getClinicDetailResponse = getClinicDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:jatya_patient_mobile/common_components/model/errors/clinic_working_hours_model.dart';

GetClinicDetailResponse getClinicDetailResponseFromJson(String str) => GetClinicDetailResponse.fromJson(json.decode(str));

String getClinicDetailResponseToJson(GetClinicDetailResponse data) => json.encode(data.toJson());

class GetClinicDetailResponse {
  bool success;
  Data data;

  GetClinicDetailResponse({
    required this.success,
    required this.data,
  });

  factory GetClinicDetailResponse.fromJson(Map<String, dynamic> json) => GetClinicDetailResponse(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Clinic clinic;
  ClinicWorkingHour workingHours;

  Data({
    required this.clinic,
    required this.workingHours,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        clinic: Clinic.fromJson(json["clinic"]),
        workingHours: ClinicWorkingHour.fromJson(json["workingHours"]),
      );

  Map<String, dynamic> toJson() => {
        "clinic": clinic.toJson(),
        "workingHours": workingHours.toJson(),
      };
}

class Clinic {
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
  dynamic ownerId;
  String onboardedBy;
  int subscriptionId;

  Clinic({
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
  });

  factory Clinic.fromJson(Map<String, dynamic> json) => Clinic(
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
      };
}

class WorkingHour {
  String clinicId;
  String weekday;
  DateTime openingTime;
  DateTime closingTime;

  WorkingHour({
    required this.clinicId,
    required this.weekday,
    required this.openingTime,
    required this.closingTime,
  });

  factory WorkingHour.fromJson(Map<String, dynamic> json) => WorkingHour(
        clinicId: json["clinicId"],
        weekday: json["weekday"],
        openingTime: DateTime.parse(json["openingTime"]),
        closingTime: DateTime.parse(json["closingTime"]),
      );

  Map<String, dynamic> toJson() => {
        "clinicId": clinicId,
        "weekday": weekday,
        "openingTime": openingTime.toIso8601String(),
        "closingTime": closingTime.toIso8601String(),
      };
}
