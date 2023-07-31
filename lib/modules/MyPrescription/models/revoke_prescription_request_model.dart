import 'dart:convert';

RevokePrescriptionSharingRequest revokePrescriptionSharingRequest(String str) =>
    RevokePrescriptionSharingRequest.fromJson(json.decode(str));
String revokeSharingModelToJson(RevokePrescriptionSharingRequest data) =>
    json.encode(data.toJson());

class RevokePrescriptionSharingRequest {
  String prescriptionId;
  String sharedById;
  String sharedToId;

  RevokePrescriptionSharingRequest({
    required this.prescriptionId,
    required this.sharedById,
    required this.sharedToId,

  });

  factory RevokePrescriptionSharingRequest.fromJson(Map<String, dynamic> json) {
    return RevokePrescriptionSharingRequest(
      prescriptionId: json["prescriptionId"],
      sharedById: json["sharedById"],
      sharedToId: json["sharedToId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "prescriptionId": prescriptionId,
      "sharedById": sharedById,
      "sharedToId": sharedToId,
    };
  }
}
