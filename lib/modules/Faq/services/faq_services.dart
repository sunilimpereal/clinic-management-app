import 'package:clinic_app/common_components/services/api_requests.dart';
import 'package:clinic_app/modules/Faq/models/faq_model.dart';
import 'package:clinic_app/modules/Faq/models/faq_response_model.dart';
import 'package:clinic_app/utils/constants/api_konstants.dart';

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
