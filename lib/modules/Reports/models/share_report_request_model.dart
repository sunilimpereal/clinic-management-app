import 'dart:convert';

List<ShareReportRequestModel> shareReportRequestModelFromJson(String str) =>
    List<ShareReportRequestModel>.from(
        json.decode(str).map((x) => ShareReportRequestModel.fromJson(x)));

String shareReportRequestModelToJson(List<ShareReportRequestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShareReportRequestModel {
  String patientReportId;
  String reportSharedById;
  String reportSharedToId;

  ShareReportRequestModel({
    required this.patientReportId,
    required this.reportSharedById,
    required this.reportSharedToId,
  });

  factory ShareReportRequestModel.fromJson(Map<String, dynamic> json) =>
      ShareReportRequestModel(
        patientReportId: json["patientReportId"],
        reportSharedById: json["reportSharedById"],
        reportSharedToId: json["reportSharedToId"],
      );

  Map<String, dynamic> toJson() => {
        "patientReportId": patientReportId,
        "reportSharedById": reportSharedById,
        "reportSharedToId": reportSharedToId,
      };
}
