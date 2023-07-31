import 'dart:developer';

import 'package:jatya_patient_mobile/modules/Profile/models/patient/get_patient_details_response.dart';
import '../../../common_components/services/api_requests.dart';
import '../../../utils/SharePref.dart';
import '../../../utils/constants/api_konstants.dart';
import '../models/patient/get_patinet_clinics_visited.dart';
import '../models/update_patient_model/patient_patch_request_model.dart';
import '../models/update_patient_model/user_put_request_model.dart';
import '../models/patient/delete_patient_response.dart';
import '../models/patient/delete_personal_data_response.dart';
import 'dart:core';

class PatientRepository {
  //get patient details
  Future<GetPatientResponse?> getpatientDetails() async {
    GetPatientResponse? response =
        await ApiRequest<String, GetPatientResponse>().get(
      url: "${ApiConstants.getPatientByuid}/${sharedPrefs.id}?userData=true",
      reponseFromJson: getPatientResponseFromJson,
    );
    return response;
  }

  //update patient details
  //update patinet
  Future<String> patchPatient(
      {required String patientId,
      required PatientPatchRequest patientPatchRequest}) async {
    String response = await ApiRequest<PatientPatchRequest, String>().patch(
      url: '${ApiConstants.updatePatient}/$patientId?removeCategory=false',
      reponseFromJson: (a) {
        return "";
      },
      request: patientPatchRequest,
      requestToJson: patientPatchRequestToJson,
    );
    return response;
  }

  //update user
  Future<String> putUser(
      {required String userId, required UserPutRequest userPutRequest}) async {
    return await ApiRequest<UserPutRequest, String>().put(
      url: "${ApiConstants.userUpdate}/$userId",
      reponseFromJson: (a) {
        return "";
      },
      request: userPutRequest,
      requestToJson: userPutRequestToJson,
    );
  }

  //get patient details
  Future<List<PatientClinicsVisit>?> getPatientClinics() async {
    List<PatientClinicsVisit>? response =
        await ApiRequest<String, List<PatientClinicsVisit>?>().get(
      url: "${ApiConstants.getAllVisitedClinic}${sharedPrefs.patientId}",
      reponseFromJson: patientClinicsVisitFromJson,
    );
    return response;
  }

  Future<DeleteUserResponse> deletePatient() async {
    // final String url = ApiConstants.delete + '/' + sharedPrefs.id! + '/deactivate';
    // Uri uri = Uri.parse(url);

    DeleteUserResponse response =
        await ApiRequest<String, DeleteUserResponse>().put(
      url: '${ApiConstants.deleteUser}/${sharedPrefs.id}/deactivate',
      request: '',
      reponseFromJson: getDeleteUserResponsefromJson,
      requestToJson: (a) => "",
    );

    return response;
  }

  Future<DeletePersonalDataResponse?> deletePersonalDataPatient() async {
    final response =
        await ApiRequest<String, DeletePersonalDataResponse>().delete(
      url: ApiConstants.deleteUserData,
      reponseFromJson: getDeletePersonalDataResponsefromJson,
    );
    log("Delete data response: $response");
    return response;
  }
}
