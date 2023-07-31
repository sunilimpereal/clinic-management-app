import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:clinic_app/modules/Auth/model/forgot_password/forgot_password_request_model.dart';
import 'package:clinic_app/modules/Auth/model/forgot_password/forgot_password_response.dart';
import 'package:clinic_app/modules/Auth/model/forgot_password/verify_forgot_password_request.dart';
import 'package:clinic_app/modules/Auth/model/forgot_password/verify_forgot_password_response.dart';
import 'package:clinic_app/modules/Auth/model/login/login_phone_request_model.dart';
import 'package:clinic_app/modules/Auth/model/login/login_request_model.dart';
import 'package:clinic_app/modules/Auth/model/login/login_response_model.dart';
import 'package:clinic_app/modules/Auth/model/login/refresh_login_response.dart';
import 'package:clinic_app/modules/Auth/model/login/refresh_request_model.dart';
import 'package:clinic_app/modules/Auth/model/register/register_response_model.dart';
import 'package:clinic_app/utils/SharePref.dart';
import 'package:clinic_app/utils/constants/api_konstants.dart';
import 'package:clinic_app/utils/constants/image_konstants.dart';

import '../../../common_components/services/api_requests.dart';
import '../model/login/login_phone_response_model.dart';
import '../model/login/mfa_phone_request.dart';
import '../model/login/patient_fromuid_response.dart';
import '../model/register/register_request_model.dart';
import '../model/register/verify_register_request_model.dart';
import '../model/register/verify_register_response_model.dart';

import 'package:http/http.dart' as http;

class AuthRepository {
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    // 'Authorization': '<Your token>'
  };
  //register user
  Future<RegisterResponse> register(
      {required RegisterRequest registerRequest}) async {
    RegisterResponse response =
        await ApiRequest<RegisterRequest, RegisterResponse>().post(
      url: ApiConstants.register,
      reponseFromJson: registerResponseFromJson,
      request: registerRequest,
      requestToJson: registerRequestToJson,
    );
    return response;
  }

  //register user
  Future<VerifyRegisterResponse> registerVerify(
      {required VerifyRegisterRequest verifyRegisterRequest}) async {
    VerifyRegisterResponse response =
        await ApiRequest<VerifyRegisterRequest, VerifyRegisterResponse>().post(
      url: ApiConstants.registerVerify,
      reponseFromJson: verifyRegisterResponseFromJson,
      request: verifyRegisterRequest,
      requestToJson: verifyRegisterRequestToJson,
    );
    return response;
  }

  //login with emmail password
  Future<LoginResponseModel> login(
      {required LoginRequestModel loginRequest,
      required bool rememberMe}) async {
    LoginResponseModel response =
        await ApiRequest<LoginRequestModel, LoginResponseModel>().post(
      url: ApiConstants.login,
      reponseFromJson: loginResponseModelFromJson,
      request: loginRequest,
      requestToJson: loginRequestModelToJson,
    );
    sharedPrefs.setAuthToken(response.data.authToken);
    sharedPrefs.setName(response.data.user.name);
    sharedPrefs.setId(response.data.user.id);
    sharedPrefs.setRememberMe(rememberMe);
    sharedPrefs.setJatyaId(response.data.user.jatyaId);
    sharedPrefs.setPatientId(response.data.user.patient.id);
    if (response.data.user.patient.uhid != null) {
      sharedPrefs.setUhid(response.data.user.patient.uhid!);
    }

    log("User Id: ${response.data.user.id}");

    if (rememberMe) {
      sharedPrefs.setRefreshToken(response.data.refreshToken);
    }
    if (response.data.user.photo == null || response.data.user.photo == "") {
      sharedPrefs
          .setProfilePic(ImagesConstants.networkImageProfilePicPlacholder);
    } else {
      sharedPrefs.setProfilePic(response.data.user.photo!);
    }
    sharedPrefs.setPatientId(response.data.user.patient.id);
    if (response.data.user.patient.patientCategory.isNotEmpty) {
      sharedPrefs.setPatientClinicId(
          response.data.user.patient.patientCategory[0].clinicId);
    }
    sharedPrefs.setEmailId(response.data.user.email);

    return response;
  }

  //login with phone otp
  Future<LoginPhoneResponse> loginPhone(
      {required LoginPhoneRequestModel loginPhoneRequestModel}) async {
    LoginPhoneResponse responseModel =
        await ApiRequest<LoginPhoneRequestModel, LoginPhoneResponse>().post(
      url: ApiConstants.loginPhone,
      reponseFromJson: loginPhoneResponseFromJson,
      request: loginPhoneRequestModel,
      requestToJson: loginPhoneRequestModelToJson,
    );
    log('requestModel.request!.phone ${loginPhoneRequestModel.phoneNumber}');

    log('responseModel.data.authToken ${responseModel.data}');

    return responseModel;
  }

  //verify phone mfa
  //verify mfa
  Future<LoginResponseModel> mfaPhone(
      {required MfaPhoneRequest mfaPhoneRequest}) async {
    LoginResponseModel res =
        await ApiRequest<MfaPhoneRequest, LoginResponseModel>().post(
      url: ApiConstants.loginPhoneMfa,
      reponseFromJson: loginResponseModelFromJson,
      request: mfaPhoneRequest,
      requestToJson: mfaPhoneRequestToJson,
    );

    log('responseModel.data.authToken ${res.data}');
    sharedPrefs.setAuthToken(res.data.authToken);
    sharedPrefs.setName(res.data.user.name);
    sharedPrefs.setId(res.data.user.id);
    sharedPrefs.setPatientId(res.data.user.patient.id);
    if (res.data.user.patient.patientCategory.isNotEmpty) {
      sharedPrefs.setPatientClinicId(
          res.data.user.patient.patientCategory[0].clinicId);
    }
    sharedPrefs.setEmailId(res.data.user.email);

    // Note Api Response has chnaged and please set this
    // sharedPrefs.setPatientId(response?.data.patient.id ?? '');

    return res;
  }

  //forgot password
  Future<ForgotPasswordResponse> forgotPassword(
      {required ForgotPasswordRequest forgotPasswordRequest}) async {
    ForgotPasswordResponse? response =
        await ApiRequest<ForgotPasswordRequest, ForgotPasswordResponse>().post(
      url: ApiConstants.forgotPassword,
      reponseFromJson: forgotPasswordResponseFromJson,
      request: forgotPasswordRequest,
      requestToJson: forgotPasswordRequestToJson,
    );
    return response;
  }

  //verify forgot password
  Future<VerifyForgotPasswordResponse> verifyForgotPassword(
      {required VerifyForgotPasswordRequest
          verifyForgotPasswordRequest}) async {
    VerifyForgotPasswordResponse response = await ApiRequest<
            VerifyForgotPasswordRequest, VerifyForgotPasswordResponse>()
        .post(
      url: ApiConstants.verifyForgotPassword,
      reponseFromJson: verifyPasswordResponseFromJson,
      request: verifyForgotPasswordRequest,
      requestToJson: verifyPasswordRequestToJson,
    );
    return response;
  }

  //get patient detail from userid
  Future<PatientFromUserIdResponse?> getPatientDetails() async {
    PatientFromUserIdResponse? response =
        await ApiRequest<String, PatientFromUserIdResponse>().get(
      url: "${ApiConstants.getPatientByuid}/${sharedPrefs.id}",
      reponseFromJson: patientFromUserIdResponseFromJson,
    );

    // sharedPrefs.setPatientId(response?.data.patient.id ?? '');
    return response;
  }

  // Social Media Login
  Future<bool> socialMediaLogin({required String url}) async {
    var uri = Uri.parse(url);
    log("ApiRequest GET : $uri");
    var response = await http.get(
      uri,
      headers: requestHeaders,
    );
    log("ApiRequest Response ${response.statusCode} : ${response.body}");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<RefreshLoginResponse?> refreshLogin() async {
    RefreshRequestModel model = RefreshRequestModel(
        refreshToken: sharedPrefs.refreshToken ?? "",
        accessToken: sharedPrefs.authToken ?? "");
    Uri uri = Uri.parse(ApiConstants.refresh);
    log(uri.toString());
    try {
      var response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: refreshRequestModelToJson(model));

      log(response.body);
      if (response.statusCode == 200) {
        RefreshLoginResponse res = refreshLoginResponseFromJson(response.body);
        sharedPrefs.setAuthToken(res.data.authToken);
        sharedPrefs.setRefreshToken(res.data.refreshToken);
        return res;
      } else {
        return null;
        // throw Exception('Failed to fetch notifications');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
  }
}
