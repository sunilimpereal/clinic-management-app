import 'package:jatya_patient_mobile/common_components/services/api_requests.dart';
import 'package:jatya_patient_mobile/modules/Faq/models/faq_model.dart';
import 'package:jatya_patient_mobile/modules/Faq/models/faq_response_model.dart';
import 'package:jatya_patient_mobile/utils/constants/api_konstants.dart';

class FaqService {
  static Future<List<FAQ>?> getAllFAQs() async {
    FaqResponseArray? faqArray =
        await ApiRequest<String, FaqResponseArray>().get(
      url: ApiConstants.getFaq,
      reponseFromJson: FaqResponseArray.fromJson,
    );
    if (faqArray == null) return [];
    return faqArray.responses;
  }
}
