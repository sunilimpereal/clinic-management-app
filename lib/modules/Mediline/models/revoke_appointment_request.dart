import 'dart:convert';

RevokeAppointmentRequest revokeAppointmentRequestModelFromJson(String str) =>
    RevokeAppointmentRequest.fromJson(json.decode(str));
String revokeAppointmentModelToJson(RevokeAppointmentRequest data) =>
    json.encode(data.toJson());

class RevokeAppointmentRequest {
  String appointmentId;
  String clinicId;

  RevokeAppointmentRequest({
    required this.appointmentId,
    required this.clinicId,
  });

  factory RevokeAppointmentRequest.fromJson(Map<String, dynamic> json) {
    return RevokeAppointmentRequest(
      clinicId: json['clinicId'],
      appointmentId: json['appointmentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clinicId': clinicId,
      'appointmentId': appointmentId,
    };
  }
}
