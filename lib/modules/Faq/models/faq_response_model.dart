import 'dart:convert';

import 'package:clinic_app/modules/Faq/models/faq_model.dart';

class FaqResponseArray {
  List<FAQ> responses;

  FaqResponseArray({required this.responses});

  factory FaqResponseArray.fromJson(String json) {
    List<FAQ> responses = [];
    List<dynamic> list = jsonDecode(json);
    for (dynamic question in list) {
      responses.add(FAQ.fromJson(question));
    }
    return FaqResponseArray(responses: responses);
  }
}
