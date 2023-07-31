import 'package:jatya_patient_mobile/modules/Mediline/models/get_clinic_response.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/models/prescription_deatils/prescription_details.dart';

class DoctorDetailsNotification {
  Doctor? doctor;
  UserData? userData;
  List<WorkingHours>? workingHours;
  Specialisation? specialisation;

  DoctorDetailsNotification({
    this.doctor,
    this.userData,
    this.workingHours,
    this.specialisation,
  });

  DoctorDetailsNotification.fromJson(Map<String, dynamic> json) {
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    userData = json['user'] != null ? UserData.fromJson(json['user']) : null;
    workingHours = json['workingHours'] != null
        ? json["workingHours"]
            .map((x) => WorkingHours.fromJson(x))
            .toList()
            .cast<WorkingHours>()
        : null;
    specialisation = json['specialisation'] != null
        ? Specialisation.fromJson(json['specialisation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    if (userData != null) {
      data['user'] = userData!.toJson();
    }
    if (workingHours != null) {
      data['workingHours'] =
          List<dynamic>.from(workingHours!.map((x) => x.toJson()));
    }
    if (specialisation != null) {
      data['specialisation'] = specialisation!.toJson();
    }
    return data;
  }
}

// class DoctorWorkingHour {
//   String id;
//   String doctorId;
//   Weekday weekday;
//   DateTime startTime;
//   DateTime endTime;

//   DoctorWorkingHour({
//     required this.id,
//     required this.doctorId,
//     required this.weekday,
//     required this.startTime,
//     required this.endTime,
//   });

//   factory DoctorWorkingHour.fromJson(Map<String, dynamic> json) =>
//       DoctorWorkingHour(
//         id: json["id"],
//         doctorId: json["doctorId"],
//         weekday: weekdayValues.map[json["weekday"]]!,
//         startTime: DateTime.parse(json["startTime"]),
//         endTime: DateTime.parse(json["endTime"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "doctorId": doctorId,
//         "weekday": weekdayValues.reverse[weekday],
//         "startTime": startTime.toIso8601String(),
//         "endTime": endTime.toIso8601String(),
//       };
// }
// class Doctor {
//   String? id;
//   String? userId;
//   String? clinicId;
//   String? qualification;
//   String? licenseNumber;
//   String? onlineFees;
//   String? inPersonFees;
//   String? createdAt;
//   //String? updatedAt;
//   String? description;
//   String? specialisation;

//   Doctor(
//       {this.id,
//       this.userId,
//       this.clinicId,
//       this.qualification,
//       this.licenseNumber,
//       this.onlineFees,
//       this.inPersonFees,
//       this.createdAt,
//       // this.updatedAt,
//       this.description,
//       this.specialisation});

//   Doctor.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['userId'];
//     clinicId = json['clinicId'];
//     qualification = json['qualification'];
//     licenseNumber = json['licenseNumber'];
//     onlineFees = json['onlineFees'];
//     inPersonFees = json['inPersonFees'];
//     createdAt = json['createdAt'];
//     //updatedAt = json['updatedAt'];
//     description = json['description'];
//     specialisation = json['specialisation'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['userId'] = userId;
//     data['clinicId'] = clinicId;
//     data['qualification'] = qualification;
//     data['licenseNumber'] = licenseNumber;
//     data['onlineFees'] = onlineFees;
//     data['inPersonFees'] = inPersonFees;
//     data['createdAt'] = createdAt;
//     //data['updatedAt'] = updatedAt;
//     data['description'] = description;
//     data['specialisation'] = specialisation;
//     return data;
//   }
// }

// class UserData {
//   String? id;
//   String? name;
//   String? email;
//   String? phoneNumber;
//   String? address;
//   String? city;
//   String? state;
//   String? country;
//   String? pinCode;
//   String? dateOfBirth;
//   String? gender;
//   bool? isDeactive;
//   bool? isMfaActive;
//   String? photo;
//   String? createdAt;
//   //String? updatedAt;
//   String? qualification;

//   UserData(
//       {this.id,
//       this.name,
//       this.email,
//       this.phoneNumber,
//       this.address,
//       this.city,
//       this.state,
//       this.country,
//       this.pinCode,
//       this.dateOfBirth,
//       this.gender,
//       this.isDeactive,
//       this.isMfaActive,
//       this.photo,
//       this.createdAt,
//       // this.updatedAt,
//       this.qualification});

//   UserData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phoneNumber = json['phoneNumber'];
//     address = json['address'];
//     city = json['city'];
//     state = json['state'];
//     country = json['country'];
//     pinCode = json['pinCode'];
//     dateOfBirth = json['dateOfBirth'];
//     gender = json['gender'];
//     isDeactive = json['isDeactive'];
//     isMfaActive = json['isMfaActive'];
//     photo = json['photo'];
//     createdAt = json['createdAt'];
//     //updatedAt = json['updatedAt'];
//     qualification = json['qualification'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['email'] = email;
//     data['phoneNumber'] = phoneNumber;
//     data['address'] = address;
//     data['city'] = city;
//     data['state'] = state;
//     data['country'] = country;
//     data['pinCode'] = pinCode;
//     data['dateOfBirth'] = dateOfBirth;
//     data['gender'] = gender;
//     data['isDeactive'] = isDeactive;
//     data['isMfaActive'] = isMfaActive;
//     data['photo'] = photo;
//     data['createdAt'] = createdAt;
//     //data['updatedAt'] = updatedAt;
//     data['qualification'] = qualification;
//     return data;
//   }
// }