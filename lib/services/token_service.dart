import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:clinic_app/utils/SharePref.dart';

Future<Map?> getRefreshToken(String patientId) async {
  const googleClientId =
      '229454198738-4sd8kivt7l45l8j7vtlp4a3alpikv630.apps.googleusercontent.com';

  const callbackUrlScheme =
      'com.googleusercontent.apps.229454198738-4sd8kivt7l45l8j7vtlp4a3alpikv630';

  final url = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
    'response_type': 'code',
    'client_id': googleClientId,
    'redirect_uri': '$callbackUrlScheme:/',
    'scope':
        'https://www.googleapis.com/auth/fitness.heart_rate.read https://www.googleapis.com/auth/fitness.blood_glucose.read https://www.googleapis.com/auth/fitness.blood_pressure.read https://www.googleapis.com/auth/fitness.body.read https://www.googleapis.com/auth/fitness.activity.read',
  });

  String str = Uri.parse(
          'https://accounts.google.com/o/oauth2/v2/auth?scope=https://www.googleapis.com/auth/fitness.heart_rate.read https://www.googleapis.com/auth/fitness.body.read https://www.googleapis.com/auth/fitness.activity.read&access_type=offline&include_granted_scopes=true&response_type=code&state=state_parameter_passthrough_value&redirect_uri=com.googleusercontent.apps.229454198738-4sd8kivt7l45l8j7vtlp4a3alpikv630:/&client_id=$googleClientId&prompt=consent')
      .toString();

  final result = await FlutterWebAuth.authenticate(
    url: url.toString(),
    // url: str,
    callbackUrlScheme:
        'com.googleusercontent.apps.229454198738-4sd8kivt7l45l8j7vtlp4a3alpikv630',
  );

  final code = Uri.parse(result).queryParameters['code'];

  final response = await http.post(
    Uri.parse('https://www.googleapis.com/oauth2/v4/token'),
    body: {
      'client_id': googleClientId,
      'redirect_uri': '$callbackUrlScheme:/',
      'grant_type': 'authorization_code',
      'code': code,
    },
  );

  final data = jsonDecode(response.body) as Map;

  if (data.containsKey('refresh_token')) {
    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer ${sharedPrefs.authToken ?? ""}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'PATCH',
        Uri.parse(
            'http://3.7.6.12:3000/api/v1/patient/$patientId?removeCategory=false'));
    request.body = jsonEncode({
      "hasGoogleWatch": true,
      "refreshToken": data['refresh_token'],
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return getDataForGraph(patientId);
    }

    return null;
  }

  return null;
}

Future<Map?> getDataForGraph(String patientId) async {
  var headers = {
    'accept': 'application/json',
    'Authorization': 'Bearer ${sharedPrefs.authToken ?? ""}',
    'Content-Type': 'application/json'
  };

  print("dummy");
  var response = await http.get(
    Uri.parse('http://3.7.6.12:3000/api/v1/smartWatch/$patientId'),
    headers: headers,
  );
  print("dummy response ${response.statusCode} ${response.body}");
  if (response.statusCode == 200) {
    return jsonDecode(response.body) as Map;
  }
  return null;
}
