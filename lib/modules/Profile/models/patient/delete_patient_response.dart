import 'dart:convert';

DeleteUserResponse getDeleteUserResponsefromJson(String str) =>  DeleteUserResponse.fromJson(json.decode(str));



class DeleteUserResponse {
  int status;
  String? data;

  DeleteUserResponse({required this.status,required this.data});

  factory DeleteUserResponse.fromJson(Map<String, dynamic> json) => DeleteUserResponse(
       status: json['status'],
       data: json['data'],
      );
}
