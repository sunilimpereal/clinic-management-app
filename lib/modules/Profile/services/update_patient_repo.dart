import 'dart:developer';

import '../../../common_components/services/api_requests.dart';
import '../../../utils/constants/api_konstants.dart';
import '../models/patient_change_password_request_model.dart';
import '../models/patient_update_response_model.dart';

// class UpdateReceptionistService {
//   Future<Response<PatinetUpdateResponseModel>?> putUpdateReceptionist(
//       {required String userId,
//       required ReceptionistUpdateRequestModel
//           receptionistUpdateRequestModel}) async {
//     Response<ReceptionistUpdateResponseModel>? response = await ApiRequest<
//             ReceptionistUpdateRequestModel, ReceptionistUpdateResponseModel>()
//         .put(
//             url: "${ApiConstants.register}/$userId",
//             request: receptionistUpdateRequestModel,
//             reponseFromJson: receptionistUpdateResponseModelFromJson,
//             requestToJson: receptionistUpdateRequestModelToJson);
//     return response;
//   }
// }

class UpdatePatienttionistPasswordService {
  Future<PatientUpdateResponseModel>? putUpdatePatientPassword(
      {required String userId,
      required PatientChangePassRequestModel
          recepChangePassRequestModel}) async {
    PatientUpdateResponseModel? response = await ApiRequest<
            PatientChangePassRequestModel, PatientUpdateResponseModel>()
        .put(
            url: "${ApiConstants.register}/$userId",
            request: recepChangePassRequestModel,
            reponseFromJson: patientUpdateResponseModelFromJson,
            requestToJson: patientChangePassRequestModelToJson);
    log("from service error msg=>>> ${response.data}");

    return response;
  }
}
