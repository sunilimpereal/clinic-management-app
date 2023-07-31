import 'dart:convert';

RevokeSharingRequest revokeSharingRequestModelFromJson(String str) =>
    RevokeSharingRequest.fromJson(json.decode(str));
String revokeSharingModelToJson(RevokeSharingRequest data) =>
    json.encode(data.toJson());

class RevokeSharingRequest {
  String patientReportId;
  String reportSharedById;
  String reportSharedToId;

  RevokeSharingRequest({
    required this.patientReportId,
    required this.reportSharedById,
    required this.reportSharedToId,
  });

  factory RevokeSharingRequest.fromJson(Map<String, dynamic> json) {
    return RevokeSharingRequest(
      patientReportId: json['patientReportId'],
      reportSharedById: json['reportSharedById'],
      reportSharedToId: json['reportSharedToId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientReportId': patientReportId,
      'reportSharedById': reportSharedById,
      'reportSharedToId': reportSharedToId,
    };
  }
}
