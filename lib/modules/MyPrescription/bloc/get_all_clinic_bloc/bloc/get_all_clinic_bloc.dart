import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:clinic_app/modules/MyPrescription/models/get_all_clinic/get_all_clinic_response.dart';
import 'package:clinic_app/modules/MyPrescription/services/prescription_services.dart';
import 'package:clinic_app/utils/SharePref.dart';

part 'get_all_clinic_event.dart';
part 'get_all_clinic_state.dart';

class GetAllClinicBloc
    extends Bloc<ClinicwisePrescriptionEvent, ClinicwisePrescriptionState> {
  GetAllClinicBloc() : super(ClinicwiseInitial()) {
    on<GetAllClinicEvents>((event, emit) async {
      GetAllClinicResponse? getAllClinicResponse;
      emit(ClinicwiseLoading());
      try {
        log("in bloc");
        getAllClinicResponse = await PrescriptionRepo.getAllClinics(
          sharedPrefs.authToken ?? "",
        );
      } catch (e) {
        log(e.toString());
      }
      if (getAllClinicResponse != null) {
        emit(ClinicwiseSuccess(getAllClinicResponse: getAllClinicResponse));
      } else {
        emit(ClinicwiseFailure());
      }
    });
  }
}
