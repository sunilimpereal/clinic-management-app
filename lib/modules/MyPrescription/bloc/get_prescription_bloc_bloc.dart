import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/models/latest_prescription.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/services/prescription_services.dart';
import 'package:jatya_patient_mobile/utils/SharePref.dart';

part 'get_prescription_bloc_event.dart';
part 'get_prescription_bloc_state.dart';

class GetPrescriptionBlocBloc
    extends Bloc<GetPrescriptionBlocEvent, GetPrescriptionBlocState> {
  GetPrescriptionBlocBloc() : super(GetPrescriptionBlocInitial()) {
    on<GetAllPrescriptionEvent>((event, emit) async {
      GetAllPrecriptionResposnse? getAllPrescriptions;
      emit(GetPrescriptionBlocloading());
      try {
        log("in bloc");
        getAllPrescriptions = await PrescriptionRepo.fetchAllPrescriptions(
          sharedPrefs.patientId ?? "",
          sharedPrefs.authToken ?? "",
        );
      
      if (getAllPrescriptions != null) {
        emit(GetPrescriptionBlocSuccess(
            getAllPrescriptions: getAllPrescriptions));
      } else {
        emit(GetPrescriptionBlocFailure());
      }
      } catch (e) {
        log(e.toString());
         emit(GetPrescriptionBlocFailure());
      }
    });
  }
}
