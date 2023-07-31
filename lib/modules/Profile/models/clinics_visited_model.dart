class ClinicVisitedModel{
  String name;
  String logo;
  String email;
  List<dynamic> mobileNumber;
  String address;
  String pinCode;
  String jatyaId;
  List<dynamic> speciality;

  ClinicVisitedModel({
    required this.name,
    required this.email,
    required this.logo,
    required this.mobileNumber,
    required this.address,
    required this.pinCode,
    required this.jatyaId,
    required this.speciality
});

  factory ClinicVisitedModel.fromJson(Map<String,dynamic> json){
    return ClinicVisitedModel(
        name: json["name"],
        email: json["emailId"],
        mobileNumber:json["mobileNumbers"],
        address: json["address"],
        pinCode: json["zipCode"],
        jatyaId: json["id"],
        speciality:json["specialities"],
        logo:json["logo"]
    );
  }
}