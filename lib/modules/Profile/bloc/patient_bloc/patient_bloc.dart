import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/modules/Profile/models/patient/get_patient_details_response.dart';
import 'package:jatya_patient_mobile/modules/Profile/models/patient/get_patinet_clinics_visited.dart';
import 'package:jatya_patient_mobile/modules/Profile/services/patient_repositroy.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  PatientBloc() : super(const PatientState()) {
    on<PatientInitialEvent>((event, emit) async {
      try {
        emit(const PatientLoadingState());
        final res = await PatientRepository().getpatientDetails();
        List<PatientClinicsVisit>? allClinics = await PatientRepository().getPatientClinics();
        if (res != null) {
          emit(PatientDetailsState(patientDetails: res.data, allClinics: allClinics ?? []));
        } else {
          emit(const PatientErrorState(error: "Error fetching Patient "));
        }
      } catch (e) {
        emit(PatientErrorState(error: "Error fetching Patient ${e.toString()}"));
      }
    });
    on<PatientGetEvent>((event, emit) {});
  }
}
