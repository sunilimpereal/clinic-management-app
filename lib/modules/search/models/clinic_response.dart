
import 'dart:convert';
import 'package:clinic_app/common_components/model/errors/clinic_working_hours_model.dart';


GetClinicResponse getClinicResponseFromJson(String str) =>
    GetClinicResponse.fromJson(json.decode(str));


class GetClinicResponse {
  List<GetClinicData>? data;

  GetClinicResponse({
    required this.data,
  });

  factory GetClinicResponse.fromJson(Map<String, dynamic> json) =>
      GetClinicResponse(
        data: json["data"] != null ? List<GetClinicData>.from(json["data"].map((x) => GetClinicData.fromJson(x))): [],
      );

 
}

class GetClinicData {
  Clinic clinic;
  Owner owner;
  ClinicWorkingHour workingHours;
  List<Subscription> subscription;
  List<Speciality> specialities;

  GetClinicData({
    required this.clinic,
    required this.workingHours,
    required this.owner,
    required this.subscription,
    required this.specialities,
  });

  factory GetClinicData.fromJson(Map<String, dynamic> json) => GetClinicData(
        clinic: Clinic.fromJson(json["clinic"]),
        owner: Owner.fromJson(json["owner"]),
        workingHours: ClinicWorkingHour.fromJson(json["workingHours"]),
        subscription: List<Subscription>.from(
            json["subscription"].map((x) => Subscription.fromJson(x))),
        specialities: json["specialities"] != null ? List<Speciality>.from(
                json["specialities"].map((x) => Speciality.fromJson(x))) : [],
         
      );

  Map<String, dynamic> toJson() => {
        "clinic": clinic.toJson(),
        "workingHours": workingHours.toJson(),
        "subscription": List<dynamic>.from(subscription.map((x) => x.toJson())),
        "specialities": List<dynamic>.from(specialities.map((x) => x)),
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
  String? termsAgreement;
  String socialMediaHandle;
  String meta;
  bool isClosed;
  String geoLocation;
  String type;
  String? ownerId;
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
    this.termsAgreement,
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
        termsAgreement: json["termsAgreement"],
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
        "termsAgreement": termsAgreement,
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

class Subscription {
  String id;
  String? planId;
  String type;
  DateTime startTime;
  DateTime endTime;
  String description;
  String clinicId;
  bool status;

  Subscription({
    required this.id,
    this.planId,
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.clinicId,
    required this.status,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"],
        planId: json["planId"],
        type: json["type"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        description: json["description"],
        clinicId: json["clinicId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "planId": planId,
        "type": type,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "description": description,
        "clinicId": clinicId,
        "status": status,
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

class Speciality {
  String id;
  String name;

  Speciality({
    required this.id,
    required this.name
  });

  factory Speciality.fromJson(Map<String, dynamic> json) => Speciality(
        id: json["id"],
        name: json["speciality"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "speciality": name
      };
}
 class Owner {
  String? id;
  String? name;
  String? photo;
  String? email;
  String? password;
  String? rsn;
  bool? isDeactive;
  bool? isMfaActive;
  List<dynamic>? ssoType;
  String? phoneNumber;
  dynamic secondaryPhoneNumber;
  dynamic countryCode;
  String? address;
  String? city;
  String? state;
  dynamic age;
  dynamic sex;
  String? country;
  DateTime? lastLoggedIn;
  DateTime? passwordLastUpdated;
  String? pinCode;
  String? qualification;
  bool? isDoctor;
  dynamic dateOfBirth;
  String? gender;
  String? jatyaId;
  dynamic maritalStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  Owner({
    this.id,
    this.name,
    this.photo,
    this.email,
    this.password,
    this.rsn,
    this.isDeactive,
    this.isMfaActive,
    this.ssoType,
    this.phoneNumber,
    this.secondaryPhoneNumber,
    this.countryCode,
    this.address,
    this.city,
    this.state,
    this.age,
    this.sex,
    this.country,
    this.lastLoggedIn,
    this.passwordLastUpdated,
    this.pinCode,
    this.qualification,
    this.isDoctor,
    this.dateOfBirth,
    this.gender,
    this.jatyaId,
    this.maritalStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        email: json["email"],
        password: json["password"],
        rsn: json["rsn"],
        isDeactive: json["isDeactive"],
        isMfaActive: json["isMfaActive"],
        ssoType: json["ssoType"] == null
            ? []
            : List<dynamic>.from(json["ssoType"]!.map((x) => x)),
        phoneNumber: json["phoneNumber"],
        secondaryPhoneNumber: json["secondaryPhoneNumber"],
        countryCode: json["countryCode"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        age: json["age"],
        sex: json["sex"],
        country: json["country"],
        lastLoggedIn: json["lastLoggedIn"] == null
            ? null
            : DateTime.parse(json["lastLoggedIn"]),
        passwordLastUpdated: json["passwordLastUpdated"] == null
            ? null
            : DateTime.parse(json["passwordLastUpdated"]),
        pinCode: json["pinCode"],
        qualification: json["qualification"],
        isDoctor: json["isDoctor"],
        dateOfBirth: json["dateOfBirth"],
        gender: json["gender"],
        jatyaId: json["jatyaId"],
        maritalStatus: json["maritalStatus"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "email": email,
        "password": password,
        "rsn": rsn,
        "isDeactive": isDeactive,
        "isMfaActive": isMfaActive,
        "ssoType":
            ssoType == null ? [] : List<dynamic>.from(ssoType!.map((x) => x)),
        "phoneNumber": phoneNumber,
        "secondaryPhoneNumber": secondaryPhoneNumber,
        "countryCode": countryCode,
        "address": address,
        "city": city,
        "state": state,
        "age": age,
        "sex": sex,
        "country": country,
        "lastLoggedIn": lastLoggedIn?.toIso8601String(),
        "passwordLastUpdated": passwordLastUpdated?.toIso8601String(),
        "pinCode": pinCode,
        "qualification": qualification,
        "isDoctor": isDoctor,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "jatyaId": jatyaId,
        "maritalStatus": maritalStatus,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
