import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jatya_patient_mobile/modules/search/models/clinic_response.dart';
import 'package:jatya_patient_mobile/modules/search/models/doctor_response.dart';
import 'package:jatya_patient_mobile/modules/search/models/medicine_response.dart';
import 'package:jatya_patient_mobile/utils/SharePref.dart';

class SearchServices {
  // Future<GetDoctorsResponse?> getDoctorsViaName(String name) async {
  //   String endpoint = "http://3.7.6.12:3000/api/v1/doctor?name=$name&user=true";
  //   GetDoctorsResponse? response =
  //       await ApiRequest<String, GetDoctorsResponse>().get(
  //     url: endpoint,
  //     reponseFromJson: getDoctorsResponseFromJson,
  //   );
  //   return response;
  // }

  // Future<GetClinicResponse?> getClinicViaName(String name) async {
  //   String endpoint = "http://3.7.6.12:3000/api/v1/clinic?search=$name";
  //   GetClinicResponse? response =
  //       await ApiRequest<String, GetClinicResponse>().get(
  //     url: endpoint,
  //     reponseFromJson: getClinicResponseFromJson,
  //   );
  //   return response;
  // }

  // Future<GetMedicineResponse?> getMedicineViaName(String name) async {
  //   String endpoint = "http://3.7.6.12:3000/api/v1/medicine?title=$name";
  //   GetMedicineResponse? response =
  //       await ApiRequest<String, GetMedicineResponse>().get(
  //     url: endpoint,
  //     reponseFromJson: getMedicineResponseFromJson,
  //   );
  //   return response;
  // }

  Future<GetDoctorsResponse?> getDoctorsViaName(String name) async {
    var url = "http://3.7.6.12:3000/api/v1/doctor?name=$name&user=true";
    Uri uri = Uri.parse(url);
    log(uri.toString());
    try {
      var response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPrefs.authToken}',
      });

      log("Search response: ${response.body}");
      if (response.statusCode == 200) {
        print("here");
        GetDoctorsResponse? getDoctorsResponse =
            GetDoctorsResponse.fromJson(jsonDecode(response.body));
        log("Doctor response: ${getDoctorsResponse.data![0].doctor.id}");
        return getDoctorsResponse;
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

  Future<GetClinicResponse?> getClinicViaName(String name) async {
    String endpoint = "http://3.7.6.12:3000/api/v1/clinic?search=$name&ownerData=true";
    Uri uri = Uri.parse(endpoint);
    log(uri.toString());
    try {
      var response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPrefs.authToken}',
      });

      log(response.body);
      // log(response.statusCode.toString());
      if (response.statusCode == 200) {
        GetClinicResponse? getClinicResponse =
            GetClinicResponse.fromJson(jsonDecode(response.body));
        return getClinicResponse;
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

  // GetMedicineResponse

  Future<GetMedicineResponse?> getMedicineViaName(String name) async {
    String endpoint = "http://3.7.6.12:3000/api/v1/medicine?title=$name";
    Uri uri = Uri.parse(endpoint);
    log(uri.toString());
    try {
      var response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPrefs.authToken}',
      });

      // log(response.body);
      // log(response.statusCode.toString());
      if (response.statusCode == 200) {
        GetMedicineResponse? getClinicResponse =
            GetMedicineResponse.fromJson(jsonDecode(response.body));
        return getClinicResponse;
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
}
