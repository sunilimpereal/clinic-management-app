import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? _sharedPref;
  init() async {
    _sharedPref ??= await SharedPreferences.getInstance();
    //print(_sharedPref!.getString("userId"));
  }

  bool? get onboarded => _sharedPref!.getBool("onboarded") ?? false;
  String? get authToken => _sharedPref!.getString("authToken") ?? "";
  String? get refreshToken => _sharedPref!.getString("refreshToken") ?? "";
  String? get name => _sharedPref!.getString("name") ?? "";
  String? get id => _sharedPref!.getString("id") ?? "";
  String? get patientId => _sharedPref!.getString("patientId") ?? "";
  String? get patientClinicId => _sharedPref!.getString("patientClinicId");
  String? get emailId => _sharedPref!.getString("emailId") ?? "";
  String get getProfilePic => _sharedPref!.getString("url") ?? "";
  String? get appointmentId => _sharedPref!.getString("appointmentId") ?? "";
  bool get rememberMe => _sharedPref!.getBool("rememberMe") ?? false;
  String? get jatyaId => _sharedPref!.getString("jatyaId") ?? "";
  String? get uhid => _sharedPref!.getString("uhid") ?? "";

  setLogout() {
    _sharedPref!.setString("authToken", '');
    _sharedPref!.setString("refreshToken", '');
    _sharedPref!.setString("name", '');
    _sharedPref!.setString("id", '');
    _sharedPref!.setString("patientId", '');
    _sharedPref!.setString("patientClinicId", '');
    _sharedPref!.setString("emailId", '');
    _sharedPref!.setString("appointmentId", '');
    _sharedPref!.setString("url", '');
    _sharedPref!.setBool("rememberMe", false);
    _sharedPref!.setString("jatyaId", '');
    _sharedPref!.setString("uhid", '');
  }

  //setters
  setAuthToken(String authToken) {
    _sharedPref!.setString("authToken", authToken);
  }

  setRefreshToken(String refreshToken) {
    _sharedPref!.setString("refreshToken", refreshToken);
  }

  setUserId(String userId) {
    _sharedPref!.setString("userId", userId);
  }

  setName(String name) {
    _sharedPref!.setString("name", name);
  }

  setId(String id) {
    _sharedPref!.setString("id", id);
  }

  setProfilePic(String url) {
    _sharedPref!.setString("url", url);
  }

  setOnboarded() {
    _sharedPref!.setBool("onboarded", true);
  }

  setPatientId(String patientId) {
    log("setting patient ID");
    log("patient Id is $patientId");
    _sharedPref!.setString("patientId", patientId);
  }

  setPatientClinicId(String patientClinicId) {
    _sharedPref!.setString("patientClinicId", patientClinicId);
  }

  setAppointmentId(String appointmentId) {
    _sharedPref!.setString("appointmentId", appointmentId);
  }

  setEmailId(String emailId) {
    _sharedPref!.setString("emailId", emailId);
  }

  setRememberMe(bool rememberMe) {
    _sharedPref!.setBool("rememberMe", rememberMe);
  }

  setJatyaId(String jatyaId) {
    _sharedPref!.setString("jatyaId", jatyaId);
  }

  setUhid(String uhid) {
    _sharedPref!.setString("uhid", uhid);
  }
}

final sharedPrefs = SharedPref();
