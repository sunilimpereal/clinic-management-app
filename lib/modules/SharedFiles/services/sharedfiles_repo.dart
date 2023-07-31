import 'dart:convert';

import '../../../common_components/services/api_requests.dart';
import '../../../utils/SharePref.dart';
import '../../../utils/constants/api_konstants.dart';
import '../models/sharedfiles_model.dart';

class SharedFilesRepository {
  Future<GetSharedFilesResponse?> getSharedFilesofPatient() async {
    GetSharedFilesResponse? response =
        await ApiRequest<String, GetSharedFilesResponse?>().get(
      url: "${ApiConstants.sharedFilesByUser}?sharedBy=${sharedPrefs.id}",
      reponseFromJson: getSharedFilesResponseFromJson,
    );
    return response;
  }

  Future<String?> getPrescriptionPdfUrl(String id) async {
    // Need work
    String? url = await ApiRequest<String, String>().get(
      url: '${ApiConstants.getAllPresciriptions}/$id',
      reponseFromJson: ((p0) => jsonDecode(p0)['data']['reportUrl']),
    );
    return url;
  }

  Future<String?> getReportPdfUrl(String id) async {
    String? url = await ApiRequest<String, String>().get(
      url: '${ApiConstants.getPrevReport}/$id',
      reponseFromJson: ((p0) => jsonDecode(p0)["data"]['url']),
    );
    return url;
  }
}
