part of 'patient_bloc.dart';

class PatientState {
  const PatientState();
}

class PatientInitialState extends PatientState {
  const PatientInitialState();
}

class PatientDetailsState extends PatientState {
  final PatientData patientDetails;
  List<PatientClinicsVisit> allClinics;
  PatientDetailsState({required this.patientDetails, required this.allClinics});
}

class PatientLoadingState extends PatientState {
  const PatientLoadingState();
}

class PatientSuccessState extends PatientState {
  const PatientSuccessState();
}

class PatientErrorState extends PatientState {
  final String error;
  const PatientErrorState({required this.error});
}
