import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/models/latest_prescription.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/services/prescription_services.dart';
import 'package:jatya_patient_mobile/utils/SharePref.dart';

part 'get_prescription_clinic_wise_event.dart';
part 'get_prescription_clinic_wise_state.dart';

class GetPrescriptionCliicWiseBloc extends Bloc<GetPrescriptionClinicWiseEvent,
    GetPrescriptionCliicWiseState> {
  GetPrescriptionCliicWiseBloc() : super(GetPrescriptionCliicWiseInitial()) {
    on<GetAllMyPrescriptionByClinicIDEvent>((event, emit) async {
      GetAllPrecriptionResposnse? getAllPrescriptions;
      emit(GetPrescriptionCliicWiseLoading());
      try {
        log("in bloc");
        getAllPrescriptions =
            await PrescriptionRepo.fetchAllPrescriptionsByClinicID(
          event.clinicId,
          sharedPrefs.authToken ?? "",
        );
      } catch (e) {
        log(e.toString());
      }
      if (getAllPrescriptions != null) {
        emit(GetPrescriptionCliicWiseSuccess(
            getAllPrescriptions: getAllPrescriptions));
      } else {
        emit(GetPrescriptionCliicWiseFailure());
      }
    });
  }
}
