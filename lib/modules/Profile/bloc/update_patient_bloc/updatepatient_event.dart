part of 'updatepatient_bloc.dart';

abstract class UpdatePatientEvent extends Equatable {
  const UpdatePatientEvent();
  @override
  List<Object> get props => [];
}

class UpdatePatientInitialEvent extends UpdatePatientEvent {
  const UpdatePatientInitialEvent();
}

class UpdatePatientGetEvent extends UpdatePatientEvent {
  const UpdatePatientGetEvent();
}

class UpdatePatientInitialFillEvent extends UpdatePatientEvent {
  final PatientData patientData;
  const UpdatePatientInitialFillEvent({required this.patientData});
}

class UpdatePatientFormChangedEvent extends UpdatePatientEvent {
  String? selectedDob;
  DropDownItem? sexValue;
  DropDownItem? maritalValue;
  String? cityValue;
  String? stateValue;
  DropDownItem? countryValue;
  String? mobileNum;
  String? name;
  String? email;
  String? addressLine1;
  String? addressLine2;
  String? postalCode;
  File? uploadedFile;
  DropDownItem? reportType;
  String? reportDate;
  int? height;
  int? weight;
  UpdatePatientFormChangedEvent({
    this.addressLine1,
    this.addressLine2,
    this.cityValue,
    this.countryValue,
    this.email,
    this.maritalValue,
    this.mobileNum,
    this.name,
    this.postalCode,
    this.reportDate,
    this.reportType,
    this.selectedDob,
    this.sexValue,
    this.stateValue,
    this.uploadedFile,
    this.height,
    this.weight,
  });
}

class UpdatePatientSubmittedEvent extends UpdatePatientEvent {}
