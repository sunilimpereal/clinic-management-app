class GetAllPrecriptionResposnse {
  String? message;
  bool? success;
  List<GetAllPrescriptionData>? data;
  String? error;

  GetAllPrecriptionResposnse(
      {this.message, this.success, this.data, this.error});

  GetAllPrecriptionResposnse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    if (json['data'] != null) {
      data = <GetAllPrescriptionData>[];
      json['data'].forEach((v) {
        data!.add(GetAllPrescriptionData.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    return data;
  }
}

class GetAllPrescriptionData {
  String? id;
  String? patientId;
  String? appointmentId;
  String? chiefComplaint;
  String? investigation;
  String? examination;
  String? provisionalDiagnosis;
  String? createdDate;
  String? name;
  String? reportUrl;
  List<Medicines>? medicines;
  String? clinicId;

  GetAllPrescriptionData(
      {this.id,
      this.patientId,
      this.appointmentId,
      this.chiefComplaint,
      this.investigation,
      this.examination,
      this.provisionalDiagnosis,
      this.createdDate,
      this.name,
      this.reportUrl,
      this.medicines});

  GetAllPrescriptionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    appointmentId = json['appointmentId'];
    chiefComplaint = json['chiefComplaint'];
    investigation = json['investigation'];
    examination = json['examination'];
    reportUrl = json['reportUrl'];
    provisionalDiagnosis = json['provisionalDiagnosis'];
    createdDate = json['createdDate'];
    name = json['name'];
    clinicId = json['appointment']?['clinicId'];
    if (json['medicines'] != null) {
      medicines = <Medicines>[];
      json['medicines'].forEach((v) {
        medicines!.add(Medicines.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['patientId'] = patientId;
    data['appointmentId'] = appointmentId;
    data['chiefComplaint'] = chiefComplaint;
    data['investigation'] = investigation;
    data['examination'] = examination;
    data['provisionalDiagnosis'] = provisionalDiagnosis;
    data['createdDate'] = createdDate;
    data['reportUrl'] = reportUrl;
    data['name'] = name;
    if (medicines != null) {
      data['medicines'] = medicines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medicines {
  String? id;
  String? prescriptionId;
  String? medicineName;
  int? dose;
  String? times;
  int? quantity;
  int? duration;
  String? route;
  String? meal;
  String? comments;
  String? warning;
  String? doseUnit;
  String? durationUnit;

  Medicines(
      {this.id,
      this.prescriptionId,
      this.medicineName,
      this.dose,
      this.times,
      this.quantity,
      this.duration,
      this.route,
      this.meal,
      this.comments,
      this.doseUnit,
      this.durationUnit,
      this.warning});

  Medicines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prescriptionId = json['prescriptionId'];
    medicineName = json['medicineName'];
    dose = json['dose'];
    times = json['times'];
    quantity = json['quantity'];
    duration = json['duration'];
    route = json['route'];
    meal = json['meal'];
    comments = json['comments'];
    warning = json['warning'];
    doseUnit = json['doseUnit'];
    durationUnit = json['durationUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['prescriptionId'] = prescriptionId;
    data['medicineName'] = medicineName;
    data['dose'] = dose;
    data['times'] = times;
    data['quantity'] = quantity;
    data['duration'] = duration;
    data['route'] = route;
    data['meal'] = meal;
    data['comments'] = comments;
    data['doseUnit'] = doseUnit;
    data['warning'] = warning;
    data['durationUnit'] = durationUnit;
    return data;
  }
}
