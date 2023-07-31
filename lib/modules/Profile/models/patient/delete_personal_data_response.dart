import 'dart:convert';

DeletePersonalDataResponse getDeletePersonalDataResponsefromJson(String str) =>  DeletePersonalDataResponse.fromJson(json.decode(str));



class DeletePersonalDataResponse {
  bool success;
  String message;

  DeletePersonalDataResponse({required this.success,required this.message});

  factory DeletePersonalDataResponse.fromJson(Map<String, dynamic> json) => DeletePersonalDataResponse(
       success: json['success'],
       message: json['message'],
      );
}
