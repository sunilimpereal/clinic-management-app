import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:clinic_app/modules/Profile/models/vaccination/get_vaccine_response.dart';
import 'package:clinic_app/modules/Profile/models/vaccination/post_vaccine_request.dart';
import 'package:clinic_app/modules/Profile/models/vaccination/post_vaccine_response.dart';
import 'package:clinic_app/utils/SharePref.dart';

import '../../../common_components/services/api_requests.dart';
import '../../../utils/constants/api_konstants.dart';

import 'package:http/http.dart' as http;

import '../models/vaccination/delete_vaccination_response.dart';

class VaccineRepository {
  //get vaccinations of logged in user
  Future<VaccinationsResponse?> getVaccines() async {
    log(sharedPrefs.id.toString());
    VaccinationsResponse? response = await ApiRequest<String, VaccinationsResponse>().get(
      url: "${ApiConstants.vaccination}?patientId=${sharedPrefs.patientId}",
      reponseFromJson: vaccinationsResponseFromJson,
    );
    return response;
  }

  //post vaccination
  Future<PostVaccineResponse> postVaccine({required List<PostVaccineRequest> postVaccineRequest}) async {
    PostVaccineResponse response = await ApiRequest<List<PostVaccineRequest>, PostVaccineResponse>().post(
      url: ApiConstants.vaccination,
      reponseFromJson: postVaccineResponseFromJson,
      request: postVaccineRequest,
      requestToJson: postVaccineRequestToJson,
    );
    return response;
  }

  //delete vaccine
  Future<DeleteVaccinationResponse?> deleteVaccine({required String vaccineId}) async {
    log(sharedPrefs.id.toString());
    DeleteVaccinationResponse? response = await ApiRequest<String, DeleteVaccinationResponse>().delete(
      url: "${ApiConstants.vaccination}/$vaccineId",
      reponseFromJson: deleteVaccinationResponseFromJson,
    );
    return response;
  }

  //upload report
  Future<String?> uploadReportFile({required File file}) async {
    var uri = Uri.parse(ApiConstants.uploadReport);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${sharedPrefs.authToken}',
    };
    final now = DateTime.now();
    final formatter = DateFormat('yyyyMMddHHmmss');
    final id = formatter.format(now).replaceAll(RegExp(r'[^\w\s]+'), '');
    log("ApiRequest GET : $uri");
    final request = http.MultipartRequest('POST', uri);
    final multipartFile = http.MultipartFile.fromBytes(
      'file',
      await file.readAsBytes(),
      filename: '$id.${file.path.split('.').last}',
    );
    request.files.add(multipartFile);
    request.headers.addAll(requestHeaders);
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    log("ApiRequest Response ${response.statusCode} $responseBody");
    if (response.statusCode == 201) {
      return json.decode(responseBody)["url"];
    } else {
      return null;
    }
  }
}
