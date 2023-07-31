// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  Data data;

  LoginResponseModel({
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  String authToken;
  String refreshToken;
  User user;

  Data({
    required this.authToken,
    required this.refreshToken,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        authToken: json["authToken"],
        refreshToken: json["refreshToken"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "authToken": authToken,
        "refreshToken": refreshToken,
        "user": user.toJson(),
      };
}

class User {
  String id;
  String email;
  String name;
  String? photo;
  List<Role> roles;
  bool isDeactive;
  bool isMfaActive;
  String? phoneNumber;
  List<dynamic> clinicsOwned;
  String jatyaId;
  Patient patient;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.photo,
    required this.roles,
    required this.isDeactive,
    required this.isMfaActive,
    required this.phoneNumber,
    required this.clinicsOwned,
    required this.jatyaId,
    required this.patient,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        photo: json["photo"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        isDeactive: json["isDeactive"],
        isMfaActive: json["isMfaActive"],
        phoneNumber: json["phoneNumber"],
        clinicsOwned: List<dynamic>.from(json["clinicsOwned"].map((x) => x)),
        jatyaId: json["jatyaId"],
        patient: Patient.fromJson(json["patient"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "photo": photo,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        "isDeactive": isDeactive,
        "isMfaActive": isMfaActive,
        "phoneNumber": phoneNumber,
        "clinicsOwned": List<dynamic>.from(clinicsOwned.map((x) => x)),
        "jatyaId": jatyaId,
        "patient": patient.toJson(),
      };
}

class Patient {
  String id;
  String userId;
  DateTime createdAt;
  DateTime? updatedAt;
  String? gender;
  String? maritalStatus;
  String? uhid;
  int? height;
  int? weight;
  bool isArchived;
  dynamic refreshToken;
  bool hasGoogleWatch;
  List<PatientCategory> patientCategory;

  Patient({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.gender,
    required this.maritalStatus,
    required this.uhid,
    required this.height,
    required this.weight,
    required this.isArchived,
    this.refreshToken,
    required this.hasGoogleWatch,
    required this.patientCategory,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["id"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        uhid: json["uhid"],
        height: json["height"],
        weight: json["weight"],
        isArchived: json["isArchived"],
        refreshToken: json["refreshToken"],
        hasGoogleWatch: json["hasGoogleWatch"],
        patientCategory: List<PatientCategory>.from(json["patientCategory"].map((x) => PatientCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt != null ? updatedAt!.toIso8601String() : DateTime.now().toIso8601String(),
        "gender": gender,
        "maritalStatus": maritalStatus,
        "uhid": uhid,
        "height": height,
        "weight": weight,
        "isArchived": isArchived,
        "refreshToken": refreshToken,
        "hasGoogleWatch": hasGoogleWatch,
        "patientCategory": List<dynamic>.from(patientCategory.map((x) => x.toJson())),
      };
}

class PatientCategory {
  String patientId;
  String clinicId;
  String category;
  Clinic clinic;

  PatientCategory({
    required this.patientId,
    required this.clinicId,
    required this.category,
    required this.clinic,
  });

  factory PatientCategory.fromJson(Map<String, dynamic> json) => PatientCategory(
        patientId: json["patientId"],
        clinicId: json["clinicId"],
        category: json["category"],
        clinic: Clinic.fromJson(json["clinic"]),
      );

  Map<String, dynamic> toJson() => {
        "patientId": patientId,
        "clinicId": clinicId,
        "category": category,
        "clinic": clinic.toJson(),
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
  String? ownerId;
  String onboardedBy;
  int? subscriptionId;
  String? termsAgreement;

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
    required this.ownerId,
    required this.onboardedBy,
    required this.subscriptionId,
    required this.termsAgreement,
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
        termsAgreement: json["termsAgreement"],
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
      };
}

class Role {
  String id;
  String userId;
  String role;

  Role({
    required this.id,
    required this.userId,
    required this.role,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        userId: json["userId"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "role": role,
      };
}
