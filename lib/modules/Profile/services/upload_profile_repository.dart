import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

import '../../../utils/SharePref.dart';
import '../../../utils/constants/api_konstants.dart';

class UploadProfileRepository {
  Future<String?> uploadReportFile({required File file}) async {
    var uri =
        Uri.parse('${ApiConstants.uploadProfileUrl}?id=${sharedPrefs.id}');
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
