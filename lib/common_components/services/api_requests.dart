import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:clinic_app/modules/Auth/services/auth_repository.dart';

import '../../utils/SharePref.dart';
import '../model/errors/error_response.dart';
import 'app_exceptions.dart';

class Response<ResModel> {
  ResModel? response;
  String? error;
  Response({
    this.response,
    this.error,
  });
}

class ApiRequest<ReqModel, ResModel> {
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${sharedPrefs.authToken}',
  };
  Future<ResModel> post({
    required String url,
    required ReqModel request,
    required ResModel Function(String) reponseFromJson,
    required String Function(ReqModel) requestToJson,
  }) async {
    var uri = Uri.parse(url);
    log("ApiRequest POST : $uri");
    log("ApiRequest Body : ${requestToJson(request)}");
    log("ApiReques POST token: ${requestHeaders['Authorization']} ");
    var response = await http.post(
      uri,
      body: requestToJson(request),
      headers: requestHeaders,
    );
    return _returnResponse(
        response: response, reponseFromJson: reponseFromJson);
  }

  Future<ResModel?> get({
    required String url,
    required Function(String) reponseFromJson,
  }) async {
    http.Response response;
    var uri = Uri.parse(url);
    log("ApiRequest GET : $uri");
    log("ApiRequest GET : ${requestHeaders['Authorization']}");
    response = await http.get(
      uri,
      headers: requestHeaders,
    );
    return _returnResponse(
        response: response, reponseFromJson: reponseFromJson);
  }

  Future<ResModel> patch({
    required String url,
    required ReqModel request,
    required ResModel Function(String) reponseFromJson,
    required String Function(ReqModel) requestToJson,
  }) async {
    var uri = Uri.parse(url);
    log("ApiRequest PATCH : $uri");
    log("ApiRequest Body : ${requestToJson(request)}");
    var response = await http.patch(
      uri,
      body: requestToJson(request),
      headers: requestHeaders,
    );
    return _returnResponse(
        response: response, reponseFromJson: reponseFromJson);
  }

  Future<ResModel> put({
    required String url,
    required ReqModel request,
    required ResModel Function(String) reponseFromJson,
    required String Function(ReqModel) requestToJson,
  }) async {
    var uri = Uri.parse(url);
    log("ApiRequest PUT : $uri");
    log("ApiRequest Body : ${requestToJson(request)}");
    var response = await http.put(
      uri,
      body: requestToJson(request),
      headers: requestHeaders,
    );
    return _returnResponse(
        response: response, reponseFromJson: reponseFromJson);
  }

  Future<ResModel?> delete({
    required String url,
    required Function(String) reponseFromJson,
  }) async {
    http.Response response;
    var uri = Uri.parse(url);
    log("ApiRequest DELTE : $uri");
    response = await http.delete(
      uri,
      headers: requestHeaders,
    );
    return _returnResponse(
        response: response, reponseFromJson: reponseFromJson);
  }

  Future<ResModel> deleterReq({
    required String url,
    required ReqModel request,
    required ResModel Function(String) reponseFromJson,
    required String Function(ReqModel) requestToJson,
  }) async {
    Uri uri = Uri.parse(url);
    log("ApiRequest DELETE : $uri");
    log("ApiRequest Body : ${requestToJson(request)}");
    dynamic res = await http.delete(
      uri,
      body: requestToJson(request),
      headers: requestHeaders,
    );
    return _returnResponse(response: res, reponseFromJson: reponseFromJson);
  }

  dynamic _returnResponse(
      {required http.Response response,
      required Function(String) reponseFromJson}) {
    log("ApiRequest Response ${response.statusCode} : ${response.body}");
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = reponseFromJson(response.body);
        // log(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        if (sharedPrefs.rememberMe) {
          AuthRepository().refreshLogin();
           break;
        }
        return null;
      case 403:
        ErrorResponse errorResponse = errorResponseFromJson(response.body);
        throw UnauthorisedException(errorResponse.error);
      case 404:
        ErrorResponse errorResponse = errorResponseFromJson(response.body);
        throw Exception(errorResponse.error);
      case 500:
        ErrorResponse errorResponse = errorResponseFromJson(response.body);
        throw BadRequestException(errorResponse.error);
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
