import 'dart:convert';

List<ShareMedilineRequest> shareMedilineRequestFromJson(String str) =>
    List<ShareMedilineRequest>.from(
        json.decode(str).map((x) => ShareMedilineRequest.fromJson(x)));

String shareMedilineRequestToJson(List<ShareMedilineRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShareMedilineRequest {
  String patientId;
  String sharedById;
  String sharedToId;

  ShareMedilineRequest({
    required this.patientId,
    required this.sharedById,
    required this.sharedToId,
  });

  factory ShareMedilineRequest.fromJson(Map<String, dynamic> json) =>
      ShareMedilineRequest(
          patientId: json["patientId"],
          sharedById: json["sharedById"],
          sharedToId: json['sharedToId']);

  Map<String, dynamic> toJson() => {
        "patientId": patientId,
        "sharedById": sharedById,
        "sharedToId": sharedToId
      };
}
