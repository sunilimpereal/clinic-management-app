import 'dart:convert';

import 'package:clinic_app/modules/MyPrescription/models/prescription_deatils/prescription_details.dart';

GetDoctorsResponse getDoctorsResponseFromJson(String str) =>
    GetDoctorsResponse.fromJson(json.decode(str));

class GetDoctorsResponse {
  List<GetDoctorsData>? data;

  GetDoctorsResponse({
    required this.data,
  });

  factory GetDoctorsResponse.fromJson(Map<String, dynamic> json) =>
      GetDoctorsResponse(
        data: json["data"] != null
            ? List<GetDoctorsData>.from(
                json["data"].map((x) => GetDoctorsData.fromJson(x)))
            : [],
      );
}

class GetDoctorsData {
  Doctorr doctor;
  List<WorkingHour> workingHours;
  User user;
  Specialisation? specialisation;

  GetDoctorsData({
    required this.doctor,
    required this.workingHours,
    required this.user,
    required this.specialisation,
  });

  factory GetDoctorsData.fromJson(Map<String, dynamic> json) => GetDoctorsData(
        doctor: Doctorr.fromJson(json["doctor"]),
        workingHours: List<WorkingHour>.from(
            json["workingHours"].map((x) => WorkingHour.fromJson(x))),
        user: User.fromJson(json["user"]),
        specialisation: json['specialisation'] == null
            ? null
            : Specialisation.fromJson(json["specialisation"]),
      );

  Map<String, dynamic> toJson() => {
        "doctor": doctor.toJson(),
        "workingHours": List<dynamic>.from(workingHours.map((x) => x.toJson())),
        "user": user.toJson(),
        "specialisation": specialisation?.toJson(),
      };
}
class Doctorr {
  String id;
  String userId;
  String clinicId;
  String qualification;
  String licenseNumber;
  String onlineFees;
  String inPersonFees;
  String? description;
  //Specialisation specialisation;

  Doctorr({
    required this.id,
    required this.userId,
    required this.clinicId,
    required this.qualification,
    required this.licenseNumber,
    required this.onlineFees,
    required this.inPersonFees,
    this.description,
    //required this.specialisation,
  });

  factory Doctorr.fromJson(Map<String, dynamic> json) => Doctorr(
        id: json["id"],
        userId: json["userId"],
        clinicId: json["clinicId"],
        qualification: json["qualification"],
        licenseNumber: json["licenseNumber"],
        onlineFees: json["onlineFees"],
        inPersonFees: json["inPersonFees"],
        //description: json["description"],
        //specialisation: Specialisation.fromJson(json["specialisation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "clinicId": clinicId,
        "qualification": qualification,
        "licenseNumber": licenseNumber,
        "onlineFees": onlineFees,
        "inPersonFees": inPersonFees,
        "description": description,
        //"specialisation": specialisation.toJson(),
      };
}

// class Specialisation {
//   String id;
//   String specialisation;

//   Specialisation({
//     required this.id,
//     required this.specialisation,
//   });

//   factory Specialisation.fromJson(Map<String, dynamic> json) => Specialisation(
//         id: json['id'],
//         specialisation: json['specialisation'],
//       );
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "specialisation": specialisation,
//       };
// }

class User {
  String id;
  String name;
  String email;
  String phoneNumber;
  String address;
  String? city;
  String? state;
  String? country;
  String? pinCode;
  Gender gender;
  bool isDeactive;
  bool isMfaActive;
  String? photo;
  DateTime createdAt;
  dynamic updatedAt;
  String? qualification;

  User({
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
    required this.isDeactive,
    required this.isMfaActive,
    required this.photo,
    required this.createdAt,
    this.updatedAt,
    this.qualification,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        address: json["address"] ?? "",
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pinCode: json["pinCode"],
        gender: genderValues.map[json["gender"]] ?? Gender.male,
        isDeactive: json["isDeactive"],
        isMfaActive: json["isMfaActive"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"],
        //qualification: json["qualification"],
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
        "gender": genderValues.reverse[gender],
        "isDeactive": isDeactive,
        "isMfaActive": isMfaActive,
        "photo": photo,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt,
        "qualification": qualification,
      };
}

enum Gender { male, female, thirdGender }

final genderValues = EnumValues({
  "FEMALE": Gender.female,
  "THIRDGENDER": Gender.thirdGender,
  "MALE": Gender.male
});

class WorkingHour {
  String id;
  String doctorId;
  Weekday weekday;
  DateTime startTime;
  DateTime endTime;

  WorkingHour({
    required this.id,
    required this.doctorId,
    required this.weekday,
    required this.startTime,
    required this.endTime,
  });

  factory WorkingHour.fromJson(Map<String, dynamic> json) => WorkingHour(
        id: json["id"],
        doctorId: json["doctorId"],
        weekday: weekdayValues.map[json["weekday"]]!,
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctorId": doctorId,
        "weekday": weekdayValues.reverse[weekday],
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
      };
}

// ignore: constant_identifier_names
enum Weekday { TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, MONDAY, SUNDAY, SATURDAY }

final weekdayValues = EnumValues({
  "FRIDAY": Weekday.FRIDAY,
  "MONDAY": Weekday.MONDAY,
  "SATURDAY": Weekday.SATURDAY,
  "SUNDAY": Weekday.SUNDAY,
  "THURSDAY": Weekday.THURSDAY,
  "TUESDAY": Weekday.TUESDAY,
  "WEDNESDAY": Weekday.WEDNESDAY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
