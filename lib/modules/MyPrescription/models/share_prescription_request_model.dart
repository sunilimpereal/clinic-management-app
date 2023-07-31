import 'dart:convert';

List<SharePrescriptionRequestModel> sharePrescriptionRequestModelFromJson(String str) =>
    List<SharePrescriptionRequestModel>.from(
        json.decode(str).map((x) => SharePrescriptionRequestModel.fromJson(x)));

String sharePrescriptionRequestModelToJson(List<SharePrescriptionRequestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SharePrescriptionRequestModel {
  String prescriptionId;
  String sharedById;
  String sharedToId;

  SharePrescriptionRequestModel({
    required this.prescriptionId,
    required this.sharedById,
    required this.sharedToId,

  });

  factory SharePrescriptionRequestModel.fromJson(Map<String, dynamic> json) =>
      SharePrescriptionRequestModel(
        prescriptionId: json["prescriptionId"],
        sharedById: json["sharedById"],
        sharedToId: json["sharedToId"],
      );

  Map<String, dynamic> toJson() => {
        "prescriptionId": prescriptionId,
        "sharedById": sharedById,
        "sharedToId": sharedToId,
      };
}
