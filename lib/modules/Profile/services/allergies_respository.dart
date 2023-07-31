import 'package:clinic_app/modules/Profile/models/allergies/post_allergy_request.dart';

import '../../../common_components/services/api_requests.dart';
import '../../../utils/SharePref.dart';
import '../../../utils/constants/api_konstants.dart';

class Allergiesrepository {
  //post allergy(new user)
  Future<String?> postAllergy({required PostAllergyRequest postAllergyRequest}) async {
    String? response = await ApiRequest<PostAllergyRequest, String>().post(
      url: ApiConstants.allergy,
      reponseFromJson: (ad) {
        return "";
      },
      request: postAllergyRequest,
      requestToJson: postAllergyRequestToJson,
    );
    return response;
  }

  //patch allergies of user
  Future<String?> updateAllergies({required PostAllergyRequest patchAllergyRequest, required String allergyId}) async {
    String? response = await ApiRequest<PostAllergyRequest, String>().patch(
      url: "${ApiConstants.allergy}/$allergyId",
      reponseFromJson: (ad) {
        return "";
      },
      request: patchAllergyRequest,
      requestToJson: postAllergyRequestToJson,
    );
    return response;
  }
}
