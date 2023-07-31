// To parse this JSON data, do
//
//     final deleteVaccinationResponse = deleteVaccinationResponseFromJson(jsonString);

import 'dart:convert';

DeleteVaccinationResponse deleteVaccinationResponseFromJson(String str) => DeleteVaccinationResponse.fromJson(json.decode(str));

String deleteVaccinationResponseToJson(DeleteVaccinationResponse data) => json.encode(data.toJson());

class DeleteVaccinationResponse {
  String message;
  bool success;
  dynamic data;
  dynamic error;

  DeleteVaccinationResponse({
    required this.message,
    required this.success,
    this.data,
    this.error,
  });

  factory DeleteVaccinationResponse.fromJson(Map<String, dynamic> json) => DeleteVaccinationResponse(
        message: json["message"],
        success: json["success"],
        data: json["data"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data,
        "error": error,
      };
}
