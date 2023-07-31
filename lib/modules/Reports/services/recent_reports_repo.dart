import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:clinic_app/common_components/services/api_requests.dart';
import 'package:clinic_app/modules/Reports/models/get_recent_report_response_model.dart';
import 'package:clinic_app/modules/Reports/models/revoke_report_request_model.dart';
import 'package:clinic_app/modules/search/models/doctor_response.dart';
import 'package:clinic_app/utils/constants/api_konstants.dart';

import '../models/share_report_request_model.dart';

class RecentReportsRepository {
  // get all recent Reports
  static Future<GetAllRecentReportsResponse>
      fetchAllRecentreportsforSpecPatient(
          String? patientId, String? token) async {
    GetAllRecentReportsResponse model;
    var response = await http.get(
        Uri.parse("${ApiConstants.getPrevReport}?patientId=$patientId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    log(response.statusCode.toString());
    log(response.body.toString());
    if (response.statusCode == 200) {
      try {
        model = GetAllRecentReportsResponse.fromJson(jsonDecode(response.body));
        log(model.message.toString());

        return model;
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        throw Exception(e.toString());
      }
      // print(response.body.toString());
    } else {
      if (kDebugMode) {
        print("Exception while Fetching recent reports");
      }
      throw Exception(response.reasonPhrase);
    }
  }

  // get all doctor for share report
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

  Future<bool> shareReportToDoctor(
      {required List<ShareReportRequestModel> requestBody}) async {
    // errors will be catched in the previous .catchError() method
    await ApiRequest<List<ShareReportRequestModel>, String>().post(
      url: ApiConstants.shareReport,
      reponseFromJson: (p0) => '',
      request: requestBody,
      requestToJson: shareReportRequestModelToJson,
    );
    return true;
  }

  Future<bool> revokeShareReportToDoctor(
      {required RevokeSharingRequest request}) async {
    await ApiRequest<RevokeSharingRequest, String>().deleterReq(
      url: ApiConstants.revokeReport,
      request: request,
      reponseFromJson: (p0) => '',
      requestToJson: revokeSharingModelToJson,
    );
    return true;
  }

  // get report by id
  Future<GetRecentReportsData?> getReportById({required String id}) async {
    return await ApiRequest<String, GetRecentReportsData>().get(
      url: '${ApiConstants.getPrevReport}/$id',
      reponseFromJson: (p0) => GetRecentReportsData.fromJson(
        jsonDecode(p0)['data'],
      ),
    );
  }
}
