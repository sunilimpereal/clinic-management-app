import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jatya_patient_mobile/modules/MyPrescription/models/download_prescription/download_prescription_details.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/models/get_all_clinic/get_all_clinic_response.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/models/latest_prescription.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/models/prescription_deatils/prescription_details.dart';
import 'package:jatya_patient_mobile/utils/constants/api_konstants.dart';

import '../../../common_components/services/api_requests.dart';
import '../../search/models/doctor_response.dart';
import '../models/revoke_prescription_request_model.dart';
import '../models/share_prescription_request_model.dart';

class PrescriptionRepo {
  // get all Prescriptions by patientId
  static Future<GetAllPrecriptionResposnse?> fetchAllPrescriptions(
    String patientId,
    String authToken,
  ) async {
    var url = ApiConstants.getAllPresciriptions;
    Uri uri = Uri.parse("$url?patientId=$patientId&appointmentData=true");
    log(uri.toString());
    try {
      http.Response response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      });

      log(response.body);
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        GetAllPrecriptionResposnse getAllPrescriptions =
            GetAllPrecriptionResposnse.fromJson(jsonDecode(response.body));
        // List<NotificationModelData> dataModel = notificationResponse.data!;
        return getAllPrescriptions;
      } else {
        return null;
        // throw Exception('Failed to fetch notifications');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
  }

  // get specific appointment(doctor and clinic details) for specific prescription
  static Future<PrescriptionDetails?>
      fetchSpecificPrescriptionsDetailsByAppointmentID(
    String appointmentId,
    String authToken,
  ) async {
    var url = ApiConstants.getSpecificAppointments;
    Uri uri = Uri.parse(
        "$url$appointmentId?patient_doctor_data=true&clinicData=true");
    log(uri.toString());
    try {
      http.Response response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      });

      log("Prescription details: ${response.body}");
      if (response.statusCode == 200) {
        dynamic jsonStr = jsonDecode(response.body);
        PrescriptionDetails prescriptionDetails =
            PrescriptionDetails.fromJson(jsonStr);
        return prescriptionDetails;
      } else {
        return null;
        // throw Exception('Failed to fetch notifications');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
  }

// download the prescription
  static Future<DownloadPrescriptionDetails?> downloadPrescriptionPdf(
    String prescriptionId,
    String authToken,
  ) async {
    var url = ApiConstants.downloadPrescription;
    Uri uri = Uri.parse("$url$prescriptionId");
    try {
      http.Response response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      });

      log(response.body);
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        DownloadPrescriptionDetails prescriptionDetails =
            DownloadPrescriptionDetails.fromJson(jsonDecode(response.body));

        return prescriptionDetails;
      } else {
        return null;
        // throw Exception('Failed to fetch notifications');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
  }

  // get all clinics
  static Future<GetAllClinicResponse?> getAllClinics(
    String authToken,
  ) async {
    var url = ApiConstants.getClinic;
    Uri uri = Uri.parse(url);
    try {
      http.Response response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      });

      log(response.body);
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        GetAllClinicResponse getAllClinicResponse =
            GetAllClinicResponse.fromJson(jsonDecode(response.body));

        return getAllClinicResponse;
      } else {
        return null;
        // throw Exception('Failed to fetch notifications');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
  }

  // get all Prescriptions by ClinicID
  static Future<GetAllPrecriptionResposnse?> fetchAllPrescriptionsByClinicID(
    String clinicId,
    String authToken,
  ) async {
    var url = ApiConstants.getAllPresciriptions;
    Uri uri = Uri.parse("$url?clinicId=$clinicId");
    log(uri.toString());
    try {
      http.Response response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      });

      log(response.body);
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        GetAllPrecriptionResposnse getAllPrescriptions =
            GetAllPrecriptionResposnse.fromJson(jsonDecode(response.body));
        // List<NotificationModelData> dataModel = notificationResponse.data!;
        return getAllPrescriptions;
      } else {
        return null;
        // throw Exception('Failed to fetch notifications');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
  }

  Future<List<GetDoctorsData>> getDoctors() async {
    try {
      GetDoctorsResponse? response =
          await ApiRequest<String, GetDoctorsResponse>().get(
        url: "${ApiConstants.doctorDetail}?user=true",
        reponseFromJson: getDoctorsResponseFromJson,
      );

      List<GetDoctorsData> list = response?.data ?? [];
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e.toString());
    }
  }

  Future<bool> sharePrescriptionToDoctor(
      {required List<SharePrescriptionRequestModel> requestBody}) async {
    // errors will be catched in the previous .catchError() method
    await ApiRequest<List<SharePrescriptionRequestModel>, String>().post(
      url: ApiConstants.sharePrescription,
      reponseFromJson: (p0) => '',
      request: requestBody,
      requestToJson: sharePrescriptionRequestModelToJson,
    );
    return true;
  }

  Future<bool> revokeSharePrescriptionToDoctor(
      {required RevokePrescriptionSharingRequest request}) async {
    await ApiRequest<RevokePrescriptionSharingRequest, String>().deleterReq(
      url: ApiConstants.revokePrescription,
      request: request,
      reponseFromJson: (p0) => '',
      requestToJson: revokeSharingModelToJson,
    );
    return true;
  }

  Future<GetAllPrescriptionData?> getPrescriptionById(
      {required String id}) async {
    GetAllPrescriptionData? response =
        await ApiRequest<String, GetAllPrescriptionData>().get(
      url: "${ApiConstants.getAllPresciriptions}/$id",
      reponseFromJson: (p0) =>
          GetAllPrescriptionData.fromJson(jsonDecode(p0)['data']),
    );
    return response;
  }
}
