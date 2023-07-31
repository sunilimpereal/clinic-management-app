class GetAllClinicResponse {
  bool? success;
  String? message;
  List<GetAllClinicData>? data;

  GetAllClinicResponse({this.success, this.message, this.data});

  GetAllClinicResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetAllClinicData>[];
      json['data'].forEach((v) {
        data!.add(GetAllClinicData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAllClinicData {
  Clinic? clinic;
  List<WorkingHours>? workingHours;

  GetAllClinicData({this.clinic, this.workingHours});

  GetAllClinicData.fromJson(Map<String, dynamic> json) {
    clinic = json['clinic'] != null ? Clinic.fromJson(json['clinic']) : null;
    if (json['workingHours'] != null) {
      workingHours = <WorkingHours>[];
      json['workingHours'].forEach((v) {
        workingHours!.add(WorkingHours.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (clinic != null) {
      data['clinic'] = clinic!.toJson();
    }
    if (workingHours != null) {
      data['workingHours'] = workingHours!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Clinic {
  String? id;
  String? name;
  String? logo;
  String? themeColor;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? emailId;
  List<String>? mobileNumbers;
  String? description;
  String? websiteURL;
  String? twitterHandle;
  String? termsAgreement;
  String? socialMediaHandle;
  String? meta;
  bool? isClosed;
  String? geoLocation;
  //List<String>? speciality;
  String? type;
  String? ownerId;
  String? onboardedBy;
  int? subscriptionId;

  Clinic(
      {this.id,
      this.name,
      this.logo,
      this.themeColor,
      this.address,
      this.city,
      this.state,
      this.country,
      this.zipCode,
      this.emailId,
      this.mobileNumbers,
      this.description,
      this.websiteURL,
      this.twitterHandle,
      this.termsAgreement,
      this.socialMediaHandle,
      this.meta,
      this.isClosed,
      this.geoLocation,
      //this.speciality,
      this.type,
      this.ownerId,
      this.onboardedBy,
      this.subscriptionId});

  Clinic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    themeColor = json['themeColor'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipCode = json['zipCode'];
    emailId = json['emailId'];
    mobileNumbers = json['mobileNumbers'].cast<String>();
    description = json['description'];
    websiteURL = json['websiteURL'];
    twitterHandle = json['twitterHandle'];
    termsAgreement = json['termsAgreement'];
    socialMediaHandle = json['socialMediaHandle'];
    meta = json['meta'];
    isClosed = json['isClosed'];
    geoLocation = json['geoLocation'];
    //speciality = json['speciality'].cast<String>();
    type = json['type'];
    ownerId = json['ownerId'];
    onboardedBy = json['onboardedBy'];
    subscriptionId = json['subscriptionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['logo'] = logo;
    data['themeColor'] = themeColor;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['zipCode'] = zipCode;
    data['emailId'] = emailId;
    data['mobileNumbers'] = mobileNumbers;
    data['description'] = description;
    data['websiteURL'] = websiteURL;
    data['twitterHandle'] = twitterHandle;
    data['termsAgreement'] = termsAgreement;
    data['socialMediaHandle'] = socialMediaHandle;
    data['meta'] = meta;
    data['isClosed'] = isClosed;
    data['geoLocation'] = geoLocation;
    //data['speciality'] = speciality;
    data['type'] = type;
    data['ownerId'] = ownerId;
    data['onboardedBy'] = onboardedBy;
    data['subscriptionId'] = subscriptionId;
    return data;
  }
}

class WorkingHours {
  String? clinicId;
  String? weekday;
  String? openingTime;
  String? closingTime;

  WorkingHours(
      {this.clinicId, this.weekday, this.openingTime, this.closingTime});

  WorkingHours.fromJson(Map<String, dynamic> json) {
    clinicId = json['clinicId'];
    weekday = json['weekday'];
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clinicId'] = clinicId;
    data['weekday'] = weekday;
    data['openingTime'] = openingTime;
    data['closingTime'] = closingTime;
    return data;
  }
}
