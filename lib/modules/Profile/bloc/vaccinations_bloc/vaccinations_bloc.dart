import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/common_components/widgets/dropdown.dart';
import 'package:jatya_patient_mobile/modules/Profile/models/vaccination/get_vaccine_response.dart';
import 'package:jatya_patient_mobile/modules/Profile/models/vaccination/post_vaccine_request.dart';
import 'package:jatya_patient_mobile/modules/Profile/models/vaccination/post_vaccine_response.dart';
import 'package:jatya_patient_mobile/modules/Profile/models/vaccination/vaccine.dart';
import 'package:jatya_patient_mobile/modules/Profile/services/vaccine_repository.dart';
import 'package:jatya_patient_mobile/utils/SharePref.dart';
part 'vaccinations_event.dart';
part 'vaccinations_state.dart';

class VaccinationsBloc extends Bloc<VaccinationsEvent, VaccinationsState> {
  VaccinationsBloc() : super(VaccinationsState()) {
    on<VaccinationReInitializeEvent>((event, emit) {
      emit(VaccinationsState());
    });
    on<VaccinationsGetVaccineListEvent>((event, emit) async {
      try {
        VaccinationsResponse? res = await VaccineRepository().getVaccines();
        if (res != null) {
          res.data.sort((a, b) => a?.vaccinationDate?.compareTo(b?.vaccinationDate ?? DateTime.now()) ?? 0);
          emit(state.copyWith(vaccineList: res.data, vaccineName: null, date: null, image: null));
        }
      } catch (e) {
        emit(VaccinationsErrorState(error: e.toString()));
      }
      // emit(state.copyWith(vaccineName: event.vaccineName));
    });
    on<VaccinationsNameChangedEvent>((event, emit) {
      emit(state.copyWith(vaccineName: event.vaccineName));
    });
    on<VaccinationsDateChangedEvent>((event, emit) {
      emit(state.copyWith(date: event.date));
    });
    on<VaccinationsImageChangedEvent>((event, emit) {
      emit(state.copyWith(image: event.image));
    });
    on<VaccinationsAddVaccinationDetailEvent>((event, emit) async {
      if (state.image != null) {
        String? imageUrl = await VaccineRepository().uploadReportFile(file: state.image!);
        if (imageUrl != null) {
          DateTime date = DateTime.parse(state.date!);
          DateTime vacDate = DateTime.utc(date.year, date.month, date.day, 20, 18, 04);

          await VaccineRepository().postVaccine(
              postVaccineRequest: [
            PostVaccineRequest(
            patientId: sharedPrefs.patientId ?? '',
              vaccinationName: state.vaccineName ?? '',
            vaccinationDate: vacDate,
            url: imageUrl,
            )
          ]);
          emit(VaccinationCreated());
        }
      }
    });
  }
}
