import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/models/latest_prescription.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/services/prescription_services.dart';
import 'package:jatya_patient_mobile/utils/SharePref.dart';

import '../../../NewAppointment/model/get_clinic_detail_response.dart';
import '../../../NewAppointment/services/appointment_repository.dart';

part 'my_prescription_event.dart';
part 'my_prescription_state.dart';

class MyPrescriptionBloc extends Bloc<MyPrescriptionEvent, MyPrescriptionState> {
  MyPrescriptionBloc() : super(MyPrescriptionInitial()) {
    on<GetAllMyPrescriptionEvent>((event, emit) async {
      GetAllPrecriptionResposnse? getAllPrescriptions;
      emit(MyPrescriptionBlocloading());
      try {
        log("in bloc");
        GetAllPrecriptionResposnse? getAllPrescriptions = await PrescriptionRepo
            .fetchAllPrescriptions(
          sharedPrefs.patientId ?? "",
          sharedPrefs.authToken ?? "",
        );
        List<String?> clinicids = getAllPrescriptions?.data?.map((e) =>
        e.clinicId).toSet().toList() ?? [];
        List<Clinic> clinicinPrescription = [];
        for (String? id in clinicids) {
          GetClinicDetailResponse? getAllPrescriptions = await AppointmentRepository()
              .getClinicDetail(clinicId: id ?? "");
          getAllPrescriptions != null ? clinicinPrescription.add(
              getAllPrescriptions.data.clinic) : null;
        }
        log("clinics  $clinicids");
        emit(MyPrescriptionBlocSuccess(
          getAllPrescriptions: getAllPrescriptions?.data ?? [],
          clinicList: clinicinPrescription,
        ));
      } catch (e) {
        log(e.toString());
        emit(MyPrescriptionBlocFailure());
      }
    }
    );
    // on<GetAllMyPrescriptionByClinicIDEvent>((event, emit) async {
    //   GetAllPrecriptionResposnse? getAllPrescriptions;
    //   emit(MyPrescriptionBlocloading());
    //   try {
    //     log("in bloc");
    //     getAllPrescriptions =
    //         await PrescriptionRepo.fetchAllPrescriptionsByClinicID(
    //       event.clinicId,
    //       sharedPrefs.authToken ?? "",
    //     );
    //   } catch (e) {
    //     log(e.toString());
    //   }
    //   if (getAllPrescriptions != null) {
    //     emit(MyPrescriptionBlocSuccess(
    //         getAllPrescriptions: getAllPrescriptions));
    //   } else {
    //     emit(MyPrescriptionBlocFailure());
    //   }
    // });
  }
}
