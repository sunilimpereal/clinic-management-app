import 'dart:convert';

ShareMedilineResponse shareMedilineResponseFromJson(String str) =>
    ShareMedilineResponse.fromJson(json.decode(str));

String shareMedilineResponseToJson(ShareMedilineResponse data) =>
    json.encode(data.toJson());

class ShareMedilineResponse {
  int? status;
  String? message;

  ShareMedilineResponse({
    this.status,
    this.message,
  });

  factory ShareMedilineResponse.fromJson(Map<String, dynamic> json) {
    return ShareMedilineResponse(
      status: json["status"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
