import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:jatya_patient_mobile/modules/Mediline/models/get_appointmens_response.dart';
import 'package:jatya_patient_mobile/modules/Mediline/models/revoke_appointment_request.dart';
import 'package:jatya_patient_mobile/modules/Mediline/models/share_appointment_request.dart';
import 'package:jatya_patient_mobile/modules/Mediline/models/share_mediline_request.dart';
import 'package:jatya_patient_mobile/modules/Mediline/models/share_mediline_response.dart';
import 'package:jatya_patient_mobile/modules/search/models/doctor_response.dart';

import '../../../common_components/services/api_requests.dart';
import '../../../utils/SharePref.dart';
import '../../../utils/constants/api_konstants.dart';
import '../models/share_appointment_response.dart';

class MedilineRepository {
  Future<GetAppointmentResponse> getappointementsofPatientPages({required int page}) async {
    GetAppointmentResponse? response =
        await ApiRequest<String, GetAppointmentResponse>().get(
      url:
          "${ApiConstants.getAllAppointments}patientId=${sharedPrefs.patientId}&limit=20&page=$page&patient_doctor_data=true&clinicData=true",
      reponseFromJson: getAppointmentResponseFromJson,
    );
    log('Appointment Response: $response');
    for (var appointment in response!.data) {
      log("Appointment title: ${appointment.appointment.title}");
    }
    //log("Appointment title: " + response.data[0].appointment.title);
    return response;
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

  /*Future<GetAllClinicResopnse?> getclinics() async {
    GetAllClinicResopnse? response =
        await ApiRequest<String, GetAllClinicResopnse>().get(
      url: "${ApiConstants.getClinic}userid=${sharedPrefs.id}",
      reponseFromJson: getAllClinicResopnseFromJson,
    );
    return response;
  }*/

  Future<GetAppointmentResponse?> getAppointmentsSearch(
      {required String search}) async {
    GetAppointmentResponse? response =
        await ApiRequest<String, GetAppointmentResponse>().get(
      url:
          "${ApiConstants.getAllAppointments}patientId=${sharedPrefs.patientId}&title=$search",
      reponseFromJson: getAppointmentResponseFromJson,
    );
    for (AppointmentDatum appointment in response!.data) {
      log("Appointment Search: ${appointment.appointment.title}");
    }
    return response;
  }

  //share appointment
  Future<ShareAppointmentResponse> shareAppointment(
      {required ShareAppointmentRequest shareAppointmentRequest}) async {
    ShareAppointmentResponse? response = await ApiRequest<ShareAppointmentRequest, ShareAppointmentResponse>()
        .post(
      url: ApiConstants.shareAppointments,
      reponseFromJson: shareAppointmentResponseFromJson,
      request: shareAppointmentRequest,
      requestToJson: shareAppointmentRequestToJson,
    );
    return response;
  }

  //revoke appointment
  Future<bool> revokeAppointmentToDoctor(
      {required String appointmentId}) async {
    await ApiRequest<RevokeAppointmentRequest, String>().delete(
      url: "${ApiConstants.revokeAppointments}/$appointmentId",
      reponseFromJson: (p0) => '',

    );
    return true;
  }

  // share mediline
  Future<bool> shareMediline(
      {required List<ShareMedilineRequest> shareMedilineRequest}) async {
    await ApiRequest<List<ShareMedilineRequest>, ShareMedilineResponse>().post(
      url: ApiConstants.shareMediline,
      reponseFromJson: shareMedilineResponseFromJson,
      request: shareMedilineRequest,
      requestToJson: shareMedilineRequestToJson,
    );
    return true;
  }

  Future<bool> revokeShareMediline(
      {required String sharedToId,
      required String patientId,
      required String sharedById}) async {
    ShareMedilineResponse? response =
        await ApiRequest<String, ShareMedilineResponse>().delete(
      url:
          "${ApiConstants.shareMediline}?sharedToId=$sharedToId&patientId=$patientId&sharedById=$sharedById",
      reponseFromJson: shareMedilineResponseFromJson,
    );

    log("Revoke Mediline Response:${response?.message}");
    return false;
  }
}
