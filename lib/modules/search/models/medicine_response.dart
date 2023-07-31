// To parse this JSON data, do
//
//     final getMedicineResponse = getMedicineResponseFromJson(jsonString);

import 'dart:convert';

GetMedicineResponse getMedicineResponseFromJson(String str) =>
    GetMedicineResponse.fromJson(json.decode(str));


class GetMedicineResponse {
  List<GetMedicineData>? data;

  GetMedicineResponse({
    required this.data,
  });

  factory GetMedicineResponse.fromJson(Map<String, dynamic> json) =>
      GetMedicineResponse(
        data: json["data"] != null ? List<GetMedicineData>.from(json["data"].map((x) => GetMedicineData.fromJson(x))) : [],
      );

  
}

class GetMedicineData {
  String id;
  String title;
  String? brandName;
  String? description;
  String? icon;
  String? medicineTypeId;
  String? reportUrl;

  GetMedicineData({
    required this.id,
    required this.title,
    this.brandName,
    this.description,
    this.icon,
    this.medicineTypeId,
    this.reportUrl,
  });

  factory GetMedicineData.fromJson(Map<String, dynamic> json) => GetMedicineData(
        id: json["id"],
        title: json["title"],
        brandName: json["brandName"],
        description: json["description"],
        icon: json["icon"],
        medicineTypeId: json["medicineTypeId"],
        reportUrl: json["reportUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "brandName": brandName,
        "description": description,
        "icon": icon,
        "medicineTypeId": medicineTypeId,
        "reportUrl": reportUrl,
      };
}
