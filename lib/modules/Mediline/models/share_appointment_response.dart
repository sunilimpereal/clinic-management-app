// To parse this JSON data, do
//
//     final shareAppointmentResponse = shareAppointmentResponseFromJson(jsonString);

import 'dart:convert';

ShareAppointmentResponse shareAppointmentResponseFromJson(String str) =>
    ShareAppointmentResponse.fromJson(json.decode(str));

String shareAppointmentResponseToJson(ShareAppointmentResponse data) =>
    json.encode(data.toJson());

/*class ShareAppointmentResponse {
  int status;
  String message;
  List<Data> data;

  ShareAppointmentResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ShareAppointmentResponse.fromJson(Map<String, dynamic> json) {
    var dataList = (json['data'] ?? []) as List<dynamic>;
    List<Data> dataItems = dataList
        .map((dataJson) => Data.fromJson(dataJson as Map<String, dynamic>))
        .toList();
    return ShareAppointmentResponse(
      status: json["status"],
      message: json["message"],
      data: dataItems,
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.map((dataItem) => dataItem.toJson()).toList(),
      };
}

class Data {
  String appointmentId;
  String clinicId;

  Data({
    required this.appointmentId,
    required this.clinicId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        appointmentId: json["appointmentId"],
        clinicId: json["clinicId"],
      );

  Map<String, dynamic> toJson() => {
        "appointmentId": appointmentId,
        "clinicId": clinicId,
      };
}*/

class ShareAppointmentResponse {
  bool? success;
  String? message;
  Data? data;

  ShareAppointmentResponse({this.success, this.message, this.data});

  ShareAppointmentResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sharedAppointmentId;

  Data({this.sharedAppointmentId});

  Data.fromJson(Map<String, dynamic> json) {
    sharedAppointmentId = json['sharedAppointmentId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'sharedAppointmentId': sharedAppointmentId
    };
  }
}

