import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jatya_patient_mobile/modules/Notifications/models/notification_model.dart';
import 'package:jatya_patient_mobile/modules/Notifications/models/undoResponse.dart';
import 'package:jatya_patient_mobile/utils/SharePref.dart';
import 'package:jatya_patient_mobile/utils/constants/api_konstants.dart';
import '../models/doctorDetailNotification.dart';

class NotificationReporsitory {
  ///////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////
  // get all Notifications
  static Future<NotificationResponse?> fetchAllNotifications(
      int page, String userId, String authToken) async {
    var url = "${ApiConstants.getAllNotifications}userId=$userId";
    Uri uri = Uri.parse(url);
    log(uri.toString());
    try {
      http.Response response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      });

      log(response.body);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        NotificationResponse notificationResponse =
            NotificationResponse.fromJson(jsonDecode(response.body));
        // List<NotificationModelData> dataModel = notificationResponse.data!;
        return notificationResponse;
      } else {
        NotificationResponse notificationResponse =
            NotificationResponse.fromJson(jsonDecode(response.body));
        if (notificationResponse.error == "No notifications for user found") {
          return notificationResponse;
        } else {
          return null;
        }
        // throw Exception('Failed to fetch notifications');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
  }

  static Future<int?> unreadNotificationCount(
      String userId, String authToken) async {
    final url =
        "${ApiConstants.getAllNotifications}userId=$userId&getNotificationCount=false&read=false";
    final uri = Uri.parse(url);
    print("here");
    try {
      http.Response response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      });
      print(url);
      print(response.body);

      if (response.statusCode == 200) {
        NotificationResponse notificationResponse =
            NotificationResponse.fromJson(json.decode(response.body));
        if (notificationResponse.data != null) {
          return notificationResponse.data!.length;
        }
        //print("Unread count: ${notificationResponse.data!.length}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
    return null;
  }

  static Future<DoctorDetailsNotification?> getNotificationDoctorDetails(
      String id) async {
    var url = "${ApiConstants.getNotificationDetails}/$id";
    Uri uri = Uri.parse(url);
    String? authToken = sharedPrefs.authToken;

    try {
      http.Response response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      });
      Map<String, dynamic> responseData =
          jsonDecode(response.body) as Map<String, dynamic>;
      Map<String, dynamic> actionData =
          responseData['actionData'] as Map<String, dynamic>;
      log("Response data: $responseData");

      DoctorDetailsNotification? doctorDetail;
      if (responseData['data']['actionType'] == 'APPOINTMENT') {
        String doctorId = actionData['doctorId'];

        doctorDetail = await getDoctorDetails(doctorId, authToken ?? '');
      }

      log("Doctor Details: $doctorDetail");
      return doctorDetail;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
  }

  static Future<DoctorDetailsNotification?> getDoctorDetails(
      String doctorId, String authToken) async {
    var url = "${ApiConstants.doctorDetail}/$doctorId?userData=true";
    Uri uri = Uri.parse(url);
    print("here");
    try {
      http.Response response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      });
      Map<String, dynamic> responseMap =
          jsonDecode(response.body) as Map<String, dynamic>;
      DoctorDetailsNotification doctorDetails =
          DoctorDetailsNotification.fromJson(responseMap['data']);
      log("Doctor detailss: $responseMap");

      return doctorDetails;

      // Map<String, dynamic> responseData =
      //     responseMap['data'] as Map<String, dynamic>;

      // Map<String, dynamic> userDetails =
      //     responseData['user'] as Map<String, dynamic>;

      // String speciality = responseData['specialisation']['specialisation'];
      // DoctorDetailNotification doctorDetailNotification =
      //     DoctorDetailNotification(
      //         doctorName: userDetails['name'],
      //         doctorPictureUrl: userDetails['photo'],
      //         doctorSpeciality: speciality);
      // return doctorDetailNotification;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
    return null;
  }

  ///////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////
  // undo all Notifications
  static Future<UndoResponseData?> undoAllNotifications(
      String userId, String authToken) async {
    log("calling in undo");
    var url = ApiConstants.undoAllNotifications;
    Uri uri = Uri.parse(url);
    print(uri.toString());
    List<String> ids = [];
    final notificationResponse =
        await fetchAllNotifications(1, userId, authToken);

    if (notificationResponse != null && notificationResponse.data != null) {
      for (var element in notificationResponse.data!) {
        ids.add(element.id!);
      }
    }
    print(ids.toString());
    List<NotificationModelData> models = [];
    for (var id in ids) {
      models.add(
        NotificationModelData(
          id: id,
          userId: userId,
          title: "",
          description: "",
          read: false,
        ),
      );
    }
    List<Map<String, dynamic>> dataModels = [];

    for (var id in ids) {
      dataModels.add({'id': id, 'read': false});
    }
    // for (var model in models) {
    //   dataModels.add(model.toJson());
    // }

    try {
      http.Response response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(dataModels),
      );

      log(response.body);
      log(response.statusCode.toString());
      final check = await fetchAllNotifications(1, userId, authToken);
      print(check!.data.toString());
      if (response.statusCode == 200) {
        UndoResponseData notificationResponse =
            UndoResponseData.fromJson(jsonDecode(response.body));
        // List<NotificationModelData> dataModel = notificationResponse.data!;
        return notificationResponse;
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

  ///////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////
  // read all Notifications
  static Future<UndoResponseData?> readAllNotifications(
      String userId, String authToken) async {
    log("calling in read");
    log(authToken);
    var url = ApiConstants.readAllNotifications;
    Uri uri = Uri.parse(url);
    List<String> ids = [];
    final notificationResponse =
        await fetchAllNotifications(1, userId, authToken);

    if (notificationResponse != null && notificationResponse.data != null) {
      for (var element in notificationResponse.data!) {
        ids.add(element.id!);
      }
    }
    List<NotificationModelData> models = [];
    for (var id in ids) {
      models.add(
        NotificationModelData(
          id: id,
          read: true,
        ),
      );
    }

    List<Map<String, dynamic>> dataModels = [];

    for (var id in ids) {
      dataModels.add({'id': id, 'read': true});
    }
    // for (var model in models) {
    //   dataModels.add(model.toJson());
    // }
    try {
      http.Response response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(dataModels),
      );

      log(response.body);
      log(response.statusCode.toString());
      final check = await fetchAllNotifications(1, userId, authToken);
      for (var i in check!.data!) {
        print('${i.read}hello');
      }
      if (response.statusCode == 200) {
        UndoResponseData notificationResponse =
            UndoResponseData.fromJson(jsonDecode(response.body));
        // List<NotificationModelData> dataModel = notificationResponse.data!;
        return notificationResponse;
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

  Future markAsRead(String id) async {
    var url = ApiConstants.readAllNotifications;
    Uri uri = Uri.parse(url);
    List<String> ids = [];
    String authToken = sharedPrefs.authToken ?? " ";
    List<Map<String, dynamic>> dataModels = [];
    dataModels.add(
      {
        'id': id,
        'read': true,
      },
    );
    try {
      http.Response response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(dataModels),
      );

      log(response.body);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        UndoResponseData notificationResponse =
            UndoResponseData.fromJson(jsonDecode(response.body));
        // List<NotificationModelData> dataModel = notificationResponse.data!;
        return notificationResponse;
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

  Future markAsUnRead(String id) async {
    var url = ApiConstants.readAllNotifications;
    Uri uri = Uri.parse(url);
    List<String> ids = [];
    String authToken = sharedPrefs.authToken ?? " ";
    List<Map<String, dynamic>> dataModels = [];
    dataModels.add(
      {
        'id': id,
        'read': false,
      },
    );
    try {
      http.Response response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(dataModels),
      );

      log(response.body);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        UndoResponseData notificationResponse =
            UndoResponseData.fromJson(jsonDecode(response.body));
        // List<NotificationModelData> dataModel = notificationResponse.data!;
        return notificationResponse;
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
