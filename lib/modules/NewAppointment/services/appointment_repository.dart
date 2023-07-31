import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:clinic_app/common_components/widgets/dropdown.dart';
import 'package:clinic_app/modules/NewAppointment/model/appointment/create_appointment.dart';
import 'package:clinic_app/modules/NewAppointment/model/appointment/create_appointment_response.dart';
import 'package:clinic_app/modules/NewAppointment/model/appointment/get_specialisation_response.dart';
import 'package:clinic_app/modules/NewAppointment/model/doctors_via_location_response.dart';

import '../../../common_components/services/api_requests.dart';
import '../../../utils/constants/api_konstants.dart';
import '../model/appointment/get_slots_response.dart';
import '../model/doctor/doctor-detail_response.dart';
import '../model/get_clinic_detail_response.dart';
import 'location_manager.dart';

class AppointmentRepository {
  //get doctors from location
  Future<List<AvailableDoctor>?> getDoctors({
    required int range,
    required String gender,
    required String speciality,
    required String date,
  }) async {
    // await getLocationPermission();
    late Position position;
    final hasPermission = await LocationManager().handleLocationPermission();
    if (hasPermission) {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position p) {
        position = p;
      }).catchError((e) {
        debugPrint(e);
      });
    }
    log("Latitude: ${position.latitude}");
    log("Longitude: ${position.longitude}");

    GeoLocationDoctorsResponse? response =
        await ApiRequest<String, GeoLocationDoctorsResponse>().get(
      //${13.00090609464154},${77.55818389540205}
      // url:
      //     "${ApiConstants.geoLocationDoctors}geoCoordinates=${13.00090609464154},${77.55818389540205}&range=$range&specialisationId=$speciality&date=$date&gender=$gender",
      // url:
      //     "${ApiConstants.geoLocationDoctors}geoCoordinates=${position.latitude},${position.longitude}&range=$range&specialisationId=$speciality&date=$date&gender=$gender",
      url:
          "${ApiConstants.geoLocationDoctors}geoCoordinates=${position.latitude},${position.longitude}&range=$range&specialisationId=$speciality&date=$date&gender=$gender",
      reponseFromJson: geoLocationDoctorsResponseFromJson,
    );
    List<AvailableDoctor>? list = response?.data;
    return list;
  }

  Future<DoctorDetailResponse?> getDcotorDetail(
      {required String doctorId}) async {
    DoctorDetailResponse? response =
        await ApiRequest<String, DoctorDetailResponse>().get(
      url: "${ApiConstants.doctorDetail}/$doctorId",
      reponseFromJson: doctorDetailResponseFromJson,
    );
    return response;
  }

  Future<CreateAppointmentResponse> bookAppointmnet(
      AppointmentRequest appointmentRequest) async {
    log("Appointment Request body: ${appointmentRequest.toJson()}");
    return await ApiRequest<AppointmentRequest, CreateAppointmentResponse>()
        .post(
      url: ApiConstants.appointment,
      reponseFromJson: createAppointmentResponseFromJson,
      request: appointmentRequest,
      requestToJson: appointmentRequestToJson,
    );
  }

  Future<GetSlotsResponse?> getSlots(
      {required DateTime date, required String doctorId}) async {
    GetSlotsResponse? response =
        await ApiRequest<String, GetSlotsResponse>().get(
      url:
          "${ApiConstants.slots}?date=${DateFormat("yyyy-MM-dd").format(date)}&doctorId=$doctorId",
      reponseFromJson: getSlotsResponseFromJson,
    );

    print('${response!.data[0].startTime}starttime');
    print('${response.data[0].endTime}endtime');
    print('${response.data[0].createdAt}createdat');
    return response;
  }

  Future<GetClinicDetailResponse?> getClinicDetail(
      {required String clinicId}) async {
    GetClinicDetailResponse? response =
        await ApiRequest<String, GetClinicDetailResponse>().get(
      url: "${ApiConstants.clinic}/$clinicId",
      reponseFromJson: getClinicDetailResponseFromJson,
    );
    log("Prescriptions response: ${response!.data.toString()}");

    return response;
  }

  Future<List<DropDownItem>> getSpecialities() async {
    List<DropDownItem> specilityOptions = [];

    GetSpecialisationResponse? response =
        await ApiRequest<String, GetSpecialisationResponse>().get(
            url: ApiConstants.specialisation,
            reponseFromJson: getSpecialisationResponseFromJson);

    List<Specialisation> specialities = response?.data ?? [];
    for (Specialisation speciality in specialities) {
      specilityOptions.add(
          DropDownItem(name: speciality.specialisation, id: speciality.id));
    }

    return specilityOptions;
  }
}
