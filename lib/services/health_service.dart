import 'dart:convert';
import 'package:health/health.dart';
import 'package:http/http.dart' as http;
import 'package:clinic_app/utils/SharePref.dart';
import 'package:clinic_app/utils/helper/helper.dart';

Future<dynamic> getAndSyncAppleHealthData(String patientId) async {
  HealthFactory health = HealthFactory();

  // define the types to get
  var types = [
    HealthDataType.BLOOD_GLUCOSE,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    HealthDataType.HEART_RATE,
  ];

  // requesting access to the data types before reading them
  bool requested = await health.requestAuthorization(types);
  if (!requested) {
    WidgetHelper.showToast('Please provide permission and try again');
  }

  var now = DateTime.now();

  // fetch health data from the last 24 hours
  List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
      now.subtract(const Duration(days: 1)), now, types);

  final appleWatchData = healthData.map((e) => e.toJson()).toList();

  var headers = {
    'accept': 'application/json',
    'Authorization': 'Bearer ${sharedPrefs.authToken ?? ""}',
    'Content-Type': 'application/json'
  };
  var request = http.Request(
      'POST', Uri.parse('http://3.7.6.12:3000/api/v1/smartWatch/apple'));
  request.body = jsonEncode({
    "patientId": patientId,
    "data": appleWatchData,
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return appleWatchData;
  }

  return null;
}
