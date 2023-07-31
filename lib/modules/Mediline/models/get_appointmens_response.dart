// To parse this JSON data, do
//
//     final getAppointmentResponse = getAppointmentResponseFromJson(jsonString);

import 'dart:convert';

GetAppointmentResponse getAppointmentResponseFromJson(String str) =>
    GetAppointmentResponse.fromJson(json.decode(str));

String getAppointmentResponseToJson(GetAppointmentResponse data) =>
    json.encode(data.toJson());

class GetAppointmentResponse {
  int status;
  List<AppointmentDatum> data;

  GetAppointmentResponse({
    required this.status,
    required this.data,
  });

  factory GetAppointmentResponse.fromJson(Map<String, dynamic> json) =>
      GetAppointmentResponse(
        status: json["status"],
        data: List<AppointmentDatum>.from(
            json["data"].map((x) => AppointmentDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}

class AppointmentDatum {
  Appointment appointment;
  AppointmentDatumPatient? patient;
  AppointmentDatumDoctor? doctor;
  List<PatientCategory>? patientCategory;

  AppointmentDatum({
    required this.appointment,
    required this.patient,
    required this.doctor,
    required this.patientCategory,
  });

  factory AppointmentDatum.fromJson(Map<String, dynamic> json) =>
      AppointmentDatum(
        appointment: Appointment.fromJson(json["appointment"]),
        patient: json["patient"] == null
            ? null
            : AppointmentDatumPatient.fromJson(json["patient"]),
        doctor: json["doctor"] == null
            ? null
            : AppointmentDatumDoctor.fromJson(json["doctor"]),
        patientCategory: json["patientCategory"] == null
            ? null
            : List<PatientCategory>.from(json["patientCategory"]
                .map((x) => PatientCategory.fromJson(x))),
      );

//   Map<String, dynamic> toJson() => {
//         "appointment": appointment.toJson(),
//         "patient": patient,
//         "doctor": doctor,
//         "patientCategory":
//             List<dynamic>.from(patientCategory!.map((x) => x.toJson())),
//       };
}

class Appointment {
  String id;
  String clinicId;
  String patientId;
  String doctorId;
  dynamic preclinicalId;
  String title;
  String? consultationDetailsId;
  DateTime startTime;
  String speciality;
  bool isEmergency;
  String priorityType;
  String status;
  String paymentStatus;
  DateTime endTime;
  DateTime createdAt;
  String appointmentType;
  DateTime appointmentDate;
  dynamic doctorWorkingHoursId;

  Appointment({
    required this.id,
    required this.clinicId,
    required this.patientId,
    required this.doctorId,
    this.preclinicalId,
    required this.title,
    required this.consultationDetailsId,
    required this.startTime,
    required this.speciality,
    required this.isEmergency,
    required this.priorityType,
    required this.status,
    required this.paymentStatus,
    required this.endTime,
    required this.createdAt,
    required this.appointmentType,
    required this.appointmentDate,
    this.doctorWorkingHoursId,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["id"],
        clinicId: json["clinicId"],
        patientId: json["patientId"],
        doctorId: json["doctorId"],
        preclinicalId: json["preclinicalId"] ?? '',
        title: json["title"],
        consultationDetailsId: json["consultationDetailsId"] ?? '',
        startTime: DateTime.parse(json["startTime"]),
        speciality: json["speciality"],
        isEmergency: json["isEmergency"],
        priorityType: json["priorityType"],
        status: json["status"],
        paymentStatus: json["paymentStatus"],
        endTime: DateTime.parse(json["endTime"]),
        createdAt: DateTime.parse(json["createdAt"]),
        appointmentType: json["appointmentType"],
        appointmentDate: DateTime.parse(json["appointmentDate"]).toLocal(),
        doctorWorkingHoursId: json["doctorWorkingHoursId"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clinicId": clinicId,
        "patientId": patientId,
        "doctorId": doctorId,
        "preclinicalId": preclinicalId,
        "title": title,
        "consultationDetailsId": consultationDetailsId,
        "startTime": startTime.toIso8601String(),
        "speciality": speciality,
        "isEmergency": isEmergency,
        "priorityType": priorityType,
        "status": status,
        "paymentStatus": paymentStatus,
        "endTime": endTime.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "appointmentType": appointmentType,
        "appointmentDate": appointmentDate.toIso8601String(),
        "doctorWorkingHoursId": doctorWorkingHoursId,
      };
}

class AppointmentDatumDoctor {
  DoctorDoctor doctor;
  UserData userData;

  AppointmentDatumDoctor({
    required this.doctor,
    required this.userData,
  });

  factory AppointmentDatumDoctor.fromJson(Map<String, dynamic> json) =>
      AppointmentDatumDoctor(
        doctor: DoctorDoctor.fromJson(json["doctor"]),
        userData: UserData.fromJson(json["userData"]),
      );

  Map<String, dynamic> toJson() => {
        "doctor": doctor.toJson(),
        "userData": userData.toJson(),
      };
}

class DoctorDoctor {
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

  DoctorDoctor({
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

  factory DoctorDoctor.fromJson(Map<String, dynamic> json) => DoctorDoctor(
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

class UserData {
  String id;
  String name;
  String email;
  String phoneNumber;
  String? address;
  String? city;
  String? state;
  String? country;
  dynamic secondaryPhoneNumber;
  String? pinCode;
  DateTime? dateOfBirth;
  String? gender;
  bool? isDeactive;
  bool? isMfaActive;
  String? photo;
  DateTime createdAt;
  DateTime? updatedAt;
  String? qualification;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
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
        secondaryPhoneNumber: json["secondaryPhoneNumber"],
        pinCode: json["pinCode"],
        dateOfBirth: json["dateOfBirth"] != null
            ? DateTime.parse(json["dateOfBirth"])
            : null,
        gender: json["gender"],
        isDeactive: json["isDeactive"],
        isMfaActive: json["isMfaActive"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now(),
        qualification: json["qualification"] ?? '',
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
        "secondaryPhoneNumber": secondaryPhoneNumber,
        "pinCode": pinCode,
        "dateOfBirth": dateOfBirth!.toIso8601String(),
        "gender": gender,
        "isDeactive": isDeactive,
        "isMfaActive": isMfaActive,
        "photo": photo,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt != null
            ? updatedAt!.toIso8601String()
            : DateTime.now().toIso8601String(),
        "qualification": qualification,
      };
}

class AppointmentDatumPatient {
  UserData userData;
  PatientPatient patient;
  Allergies? allergies;
  List<PatientCategory> patientCategory;

  AppointmentDatumPatient({
    required this.userData,
    required this.patient,
    required this.allergies,
    required this.patientCategory,
  });

  factory AppointmentDatumPatient.fromJson(Map<String, dynamic> json) =>
      AppointmentDatumPatient(
        userData: UserData.fromJson(json["userData"]),
        patient: PatientPatient.fromJson(json["patient"]),
        allergies: json["allergies"] != null ?  Allergies.fromJson(json["allergies"]) : null,
        patientCategory: List<PatientCategory>.from(
            json["patientCategory"].map((x) => PatientCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userData": userData.toJson(),
        "patient": patient.toJson(),
        "allergies": allergies!.toJson(),
        "patientCategory":
            List<dynamic>.from(patientCategory.map((x) => x.toJson())),
      };
}

class Allergies {
  String id;
  String patientId;
  List<String> medicineAllergies;
  List<String> foodAllergies;
  List<String> petAllergies;
  String other;

  Allergies({
    required this.id,
    required this.patientId,
    required this.medicineAllergies,
    required this.foodAllergies,
    required this.petAllergies,
    required this.other,
  });

  factory Allergies.fromJson(Map<String, dynamic> json) => Allergies(
        id: json["id"],
        patientId: json["patientId"],
        medicineAllergies: List<String>.from(json["medicineAllergies"]),
        foodAllergies: List<String>.from(json["foodAllergies"]),
        petAllergies: List<String>.from(json["petAllergies"]),
        other: json["other"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patientId": patientId,
        "medicineAllergies": List<String>.from(medicineAllergies.map((x) => x)),
        "foodAllergies": List<String>.from(foodAllergies.map((x) => x)),
        "petAllergies": List<String>.from(petAllergies.map((x) => x)),
      };
}

class PatientPatient {
  String id;
 // String gender;
  String maritalStatus;
  DateTime createdAt;
  bool isArchived;
  DateTime updatedAt;
  String userId;

  PatientPatient({
    required this.id,
   // required this.gender,
    required this.maritalStatus,
    required this.createdAt,
    required this.isArchived,
    required this.updatedAt,
    required this.userId,
  });

  factory PatientPatient.fromJson(Map<String, dynamic> json) => PatientPatient(
        id: json["id"],
        //gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        isArchived: json["isArchived"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        //"gender": gender,
        "maritalStatus": maritalStatus,
        "createdAt": createdAt.toIso8601String(),
        "isArchived": isArchived,
        "updatedAt": updatedAt.toIso8601String(),
        "userId": userId,
      };
}

class PatientCategory {
  // String id;
  String patientId;
  String clinicId;
  Category category;

  PatientCategory({
    // required this.id,
    required this.patientId,
    required this.clinicId,
    required this.category,
  });

  factory PatientCategory.fromJson(Map<String, dynamic> json) =>
      PatientCategory(
        // id: json["id"],
        patientId: json["patientId"],
        clinicId: json["clinicId"],
        category: categoryValues.map[json["category"]]!,
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "patientId": patientId,
        "clinicId": clinicId,
        "category": categoryValues.reverse[category],
      };
}

enum Category { regular, vip, critical, irregular }

final categoryValues = EnumValues({
  "CRITICAL": Category.critical,
  "VIP": Category.vip,
  "REGULAR": Category.regular,
  "IRREGULAR": Category.irregular
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
