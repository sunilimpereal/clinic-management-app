import 'dart:convert';

RevokeMedilineRequest revokeMedilineRequestModelFromJson(String str) =>
    RevokeMedilineRequest.fromJson(json.decode(str));
String revokeMedilineModelToJson(RevokeMedilineRequest data) =>
    json.encode(data.toJson());

class RevokeMedilineRequest {
  String MedilineId;
  String clinicId;

  RevokeMedilineRequest({
    required this.MedilineId,
    required this.clinicId,
  });

  factory RevokeMedilineRequest.fromJson(Map<String, dynamic> json) {
    return RevokeMedilineRequest(
      clinicId: json['clinicId'],
      MedilineId: json['MedilineId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clinicId': clinicId,
      'MedilineId': MedilineId,
    };
  }
}
