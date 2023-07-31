import 'dart:convert';

GetAllAppointmentsResponse getAllAppointmentsResponseFromJson(String str) =>
    GetAllAppointmentsResponse.fromJson(json.decode(str));

String getAllAppointmentsResponseToJson(GetAllAppointmentsResponse data) =>
    json.encode(data.toJson());

class GetAllAppointmentsResponse {
  int status;
  List<GetAllAppointmentsData> data;

  GetAllAppointmentsResponse({
    required this.status,
    required this.data,
  });

  factory GetAllAppointmentsResponse.fromJson(Map<String, dynamic> json) =>
      GetAllAppointmentsResponse(
        status: json["status"],
        data: List<GetAllAppointmentsData>.from(
            json["data"].map((x) => GetAllAppointmentsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
// class GetAllAppointmentsData {
//   GetAllAppointmentsDataModel? appointment;
//   GetAllAppointmentsPatientData? patient;
//   GetAllAppointmentsDoctorData? doctor;

class GetAllAppointmentsData {
  GetAllAppointmentsDataModel appointment;
  GetAllAppointmentsPatientData patient;
  GetAllAppointmentsDoctorData doctor;
  GetAllAppointmentsClinicData? clinic;
  List<PatientCategory> patientCategory;

  GetAllAppointmentsData({
    required this.appointment,
    required this.patient,
    required this.doctor,
    required this.clinic,
    required this.patientCategory,
  });

  factory GetAllAppointmentsData.fromJson(Map<String, dynamic> json) =>
      GetAllAppointmentsData(
        appointment: GetAllAppointmentsDataModel.fromJson(json["appointment"]),
        patient: GetAllAppointmentsPatientData.fromJson(json["patient"]),
        doctor: GetAllAppointmentsDoctorData.fromJson(json["doctor"]),
        clinic: GetAllAppointmentsClinicData.fromJson(json["clinic"]),
        patientCategory: List<PatientCategory>.from(
            json["patientCategory"].map((x) => PatientCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "appointment": appointment.toJson(),
        "patient": patient.toJson(),
        "doctor": doctor.toJson(),
        "patientCategory":
            List<dynamic>.from(patientCategory.map((x) => x.toJson())),
      };
}

class GetAllAppointmentsDataModel {
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
  String? doctorWorkingHoursId;

  GetAllAppointmentsDataModel({
    required this.id,
    required this.clinicId,
    required this.patientId,
    required this.doctorId,
    this.preclinicalId,
    required this.title,
    this.consultationDetailsId,
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

  factory GetAllAppointmentsDataModel.fromJson(Map<String, dynamic> json) =>
      GetAllAppointmentsDataModel(
        id: json["id"],
        clinicId: json["clinicId"],
        patientId: json["patientId"],
        doctorId: json["doctorId"],
        preclinicalId: json["preclinicalId"],
        title: json["title"],
        consultationDetailsId: json["consultationDetailsId"],
        startTime: DateTime.parse(json["startTime"]),
        speciality: json["speciality"],
        isEmergency: json["isEmergency"],
        priorityType: json["priorityType"],
        status: json["status"],
        paymentStatus: json["paymentStatus"],
        endTime: DateTime.parse(json["endTime"]),
        createdAt: DateTime.parse(json["createdAt"]),
        appointmentType: json["appointmentType"],
        appointmentDate: DateTime.parse(json["appointmentDate"]),
        doctorWorkingHoursId: json["doctorWorkingHoursId"],
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

class GetAllAppointmentsDoctorData {
  DoctorDoctor doctor;
  UserData userData;

  GetAllAppointmentsDoctorData({
    required this.doctor,
    required this.userData,
  });

  factory GetAllAppointmentsDoctorData.fromJson(Map<String, dynamic> json) =>
      GetAllAppointmentsDoctorData(
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
    this.specialisationId,
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
  bool isDeactive;
  bool isMfaActive;
  String? photo;
  DateTime createdAt;
  DateTime updatedAt;
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
    this.dateOfBirth,
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
        dateOfBirth: json["dateOfBirth"] == null
            ? DateTime.now()
            : DateTime.parse(json["dateOfBirth"]),
        gender: json["gender"],
        isDeactive: json["isDeactive"],
        isMfaActive: json["isMfaActive"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        qualification: json["qualification"],
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
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "gender": gender,
        "isDeactive": isDeactive,
        "isMfaActive": isMfaActive,
        "photo": photo,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "qualification": qualification,
      };
}

class GetAllAppointmentsPatientData {
  UserData userData;
  PatientPatient patient;
  Allergies? allergies;
  List<PatientCategory> patientCategory;

  GetAllAppointmentsPatientData({
    required this.userData,
    required this.patient,
    required this.allergies,
    required this.patientCategory,
  });

  factory GetAllAppointmentsPatientData.fromJson(Map<String, dynamic> json) =>
      GetAllAppointmentsPatientData(
        userData: UserData.fromJson(json["userData"]),
        patient: PatientPatient.fromJson(json["patient"]),
        allergies: json["allergies"] == null ? null : Allergies.fromJson(json["allergies"]),
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

class PatientPatient {
  String id;
  String? gender;
  String maritalStatus;
  DateTime createdAt;
  bool isArchived;
  DateTime updatedAt;
  String userId;

  PatientPatient({
    required this.id,
    required this.gender,
    required this.maritalStatus,
    required this.createdAt,
    required this.isArchived,
    required this.updatedAt,
    required this.userId,
  });

  factory PatientPatient.fromJson(Map<String, dynamic> json) => PatientPatient(
        id: json["id"],
        gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        isArchived: json["isArchived"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
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

class PatientCategory {
  String patientId;
  String clinicId;
  String category;

  PatientCategory({
    required this.patientId,
    required this.clinicId,
    required this.category,
  });

  factory PatientCategory.fromJson(Map<String, dynamic> json) =>
      PatientCategory(
        patientId: json["patientId"],
        clinicId: json["clinicId"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "patientId": patientId,
        "clinicId": clinicId,
        "category": category,
      };
}

class GetAllAppointmentsClinicData {
  String? geoLocation;

  GetAllAppointmentsClinicData({
    required this.geoLocation,
  });

  factory GetAllAppointmentsClinicData.fromJson(Map<String, dynamic> json) =>
      GetAllAppointmentsClinicData(
        geoLocation: json["geoLocation"],
      );
}
