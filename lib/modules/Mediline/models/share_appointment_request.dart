// To parse this JSON data, do
//
//     final shareAppointmentRequest = shareAppointmentRequestFromJson(jsonString);

import 'dart:convert';

ShareAppointmentRequest shareAppointmentRequestFromJson(String str) =>
    ShareAppointmentRequest.fromJson(json.decode(str));

String shareAppointmentRequestToJson(ShareAppointmentRequest data) =>
    json.encode(data.toJson());

class ShareAppointmentRequest {
  String sharedById;
  String sharedToId;
  String appointmentId;

  ShareAppointmentRequest(
      {required this.sharedById, required this.sharedToId, required this.appointmentId});

  factory ShareAppointmentRequest.fromJson(Map<String, dynamic> json) {
    return ShareAppointmentRequest(
      sharedById: json['sharedById'],
      sharedToId: json['sharedToId'],
      appointmentId: json['appointmentId'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
    'sharedById': sharedById,
    'sharedToId': sharedToId,
    'appointmentId': appointmentId,
  };
  }
}
/*class ShareAppointmentRequest {
  String appointmentId;
  String sharedById;
  String sharedToId;

  ShareAppointmentRequest({
    required this.sharedById,
    required this.sharedToId,
    required this.appointmentId
  });

  factory ShareAppointmentRequest.fromJson(Map<String, dynamic> json) => ShareAppointmentRequest(
      sharedById = json['sharedById'];
      sharedToId = json['sharedToId'];
      appointmentId = json['appointmentId'];
      );

  Map<String, dynamic> toJson() => {
  data['sharedById'] = this.sharedById;
  data['sharedToId'] = this.sharedToId;
  data['appointmentId'] = this.appointmentId;
      };
}*/
