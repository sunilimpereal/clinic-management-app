import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/modules/Mediline/models/get_appointmens_response.dart';
import 'package:jatya_patient_mobile/modules/Mediline/services/mediline_repository.dart';
import 'package:jatya_patient_mobile/modules/NewAppointment/services/appointment_repository.dart';

import '../../NewAppointment/model/get_clinic_detail_response.dart';

part 'mediline_event.dart';
part 'mediline_state.dart';

class MedilineBloc extends Bloc<MedilineEvent, MedilineState> {
  MedilineBloc() : super(const MedilineState()) {
    int page = 1;
    on<MedilineGetAllAppointmetns>((event, emit) async {
      emit(MedilineLoadingState());
      try {
        GetAppointmentResponse? res = await MedilineRepository().getappointementsofPatientPages(page: 1);
        // GetAllClinicResopnse? clinicRes = await MedilineRepository().getclinics();
        List<String> clinicIds = res.data.map((e) => e.appointment.clinicId).toSet().toList() ?? [];
        List<Clinic> clinicInAppointmnets = [];
        for (String id in clinicIds) {
          GetClinicDetailResponse? res = await AppointmentRepository().getClinicDetail(clinicId: id);
          res != null ? clinicInAppointmnets.add(res.data.clinic) : null;
        }

        log("clinics  $clinicIds");

        // emit(state.copyWith(appointmentList: res?.data ?? [], clinicList: clinicInAppointmnets));
        emit(MedilineSuccessState(
          appointmentList: res.data,
          clinicList: clinicInAppointmnets,
          isEnd: res.data.length < 20
        ));
      } catch (e) {
        if (e.toString() == 'Not Found') {
          emit(const MedilineErrorState(error: "No Appointments Found"));
        } else {
          emit(const MedilineErrorState(error: "Error fetching data"));
        }
      }
    });
    on<MedilineGetAppointmetnsLoadMore>((event, emit) async {
      emit(MedilineLoadingState());
      try {
        GetAppointmentResponse? res = await MedilineRepository().getappointementsofPatientPages(page: ++page);
        List<String> clinicIds = res.data.map((e) => e.appointment.clinicId).toSet().toList() ?? [];
        List<Clinic> clinicInAppointmnets = [];
        for (String id in clinicIds) {
          GetClinicDetailResponse? res = await AppointmentRepository().getClinicDetail(clinicId: id);
          res != null ? clinicInAppointmnets.add(res.data.clinic) : null;
        }

        if (state.appointmentList != null) {
          emit(MedilineSuccessState(
            appointmentList: state.appointmentList! + res.data,
            clinicList: state.clinicList! + clinicInAppointmnets,
          ));
        }
      } catch (e) {
        emit(const MedilineSuccessState(isEnd: true));
      }
    });

    on<MedilineSelectedDateChangedEvent>((event, emit) {});
    on<MedilineGetAppointemtnListEvent>((event, emit) {});
    on<MedilineEmptyAppointmentListEvent>((event, emit) {});
    on<MedilineFailedGetAppointListEvent>((event, emit) {});
  }
}
