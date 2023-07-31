// To parse this JSON data, do
//
//     final getSharedFilesResponse = getSharedFilesResponseFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

GetSharedFilesResponse getSharedFilesResponseFromJson(String str) =>
    GetSharedFilesResponse.fromJson(json.decode(str));

String getSharedFilesResponseToJson(GetSharedFilesResponse data) =>
    json.encode(data.toJson());

class GetSharedFilesResponse {
  int status;
  List<SharedFileData> data;

  GetSharedFilesResponse({
    required this.status,
    required this.data,
  });

  factory GetSharedFilesResponse.fromJson(Map<String, dynamic> json) =>
      GetSharedFilesResponse(
        status: json["status"],
        data: List<SharedFileData>.from(
            json["data"].map((x) => SharedFileData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

enum SharedRecod {
  ShareReport,
  SharedPrescription,
  ShareMediline,
  ShareAppointment,
  other
}

class SharedFileData {
  SharedRecod sharedRecord;
  DateTime createdAt;
  String id;
  User user;

  SharedFileData({
    required this.sharedRecord,
    required this.createdAt,
    required this.id,
    required this.user,
  });

  factory SharedFileData.fromJson(Map<String, dynamic> json) {
    SharedRecod sharedFileEnum;
    switch (json["sharedRecord"]) {
      case "SharedPrescription":
        sharedFileEnum = SharedRecod.SharedPrescription;
        break;
      case "ShareReport":
        sharedFileEnum = SharedRecod.ShareReport;
        break;
      case "SharedPatientMediline":
        sharedFileEnum = SharedRecod.ShareMediline;
        break;
      case "ShareAppointment":
        sharedFileEnum = SharedRecod.ShareAppointment;
        break;
      default:
        sharedFileEnum = SharedRecod.other;
    }
    return SharedFileData(
      sharedRecord: sharedFileEnum,
      createdAt: DateTime.parse(json["createdAt"]),
      id: json["id"],
      user: User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "sharedRecord": sharedRecord.name,
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "sharedBy": user.toJson(),
      };
}

class User {
  String id;
  String name;
  String? photo;

  User({
    required this.id,
    required this.name,
    required this.photo,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "photo": photo};
}
