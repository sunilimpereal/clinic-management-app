import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jatya_patient_mobile/common_components/services/form_submission_status.dart';
import 'package:jatya_patient_mobile/common_components/widgets/dropdown.dart';
import 'package:jatya_patient_mobile/modules/NewAppointment/model/appointment/get_slots_response.dart';
import 'package:jatya_patient_mobile/modules/NewAppointment/services/appointment_repository.dart';

import '../model/doctors_via_location_response.dart';
part 'appointment_state.dart';
part 'appointment_event.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentRepository appointmentRepository;
  AppointmentBloc({required this.appointmentRepository})
      : super(AppointmentState()) {
    on<GetSpecialityEvent>((event, emit) async {
      try {
      await appointmentRepository.getSpecialities().then((value) {
        emit(state.copyWith(speciality: value.first, specialityOptions: value));
      });
      } catch (e) {
         emit(state.copyWith(
            formStatus: FormSubmissionFailed("No Specialities Found")));
      }
    });
    on<SpecialityChangedEvent>((event, emit) {
      emit(state.copyWith(speciality: event.speciality));
      log(event.speciality.toString());
    });
    on<RangeChangedEvent>((event, emit) {
      emit(state.copyWith(range: event.range));
    });
    on<IsEmergencyChangedEvent>((event, emit) {
      emit(state.copyWith(isEmergency: event.isEmergency));
    });
    on<AppointmentDateChangedEvent>((event, emit) {
      emit(state.copyWith(appointmentDate: event.dateTime));
      log(state.appointmentDate.toString());
    });

    on<DoctorGenderChangedEvent>((event, emit) {
      emit(state.copyWith(doctorGender: event.gender));
    });
    on<ShowAvailableDoctorsEvent>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        List<AvailableDoctor>? doctors = await appointmentRepository.getDoctors(
          date: state.appointmentDate != null
              ? state.appointmentDate.toString()
              : DateTime.now().toString(),
          gender: state.doctorGender?.name ?? '',
          range: state.range,
          speciality: state.speciality?.id ?? '',
        );
        if (doctors != null) {
          emit(state.copyWith(
              formStatus: FormSubmissionSuccess(), doctors: doctors));
        } else {
          emit(state.copyWith(
              formStatus: FormSubmissionFailed("No Doctors Found")));
        }
      } catch (e) {
        emit(state.copyWith(
            formStatus: FormSubmissionFailed("No Doctors Found")));
      }
    });
    on<ReinitalizeAppointmentEvent>((event, emit) {
      emit(state.copyWith(
          formStatus: const InitialFormStatus(),
          speciality:  const DropDownItem(name: 'Urologist', id: '1'),
          specialityOptions: const [DropDownItem(name: 'Urologist', id: '1')],
          range: 4,
          isEmergency: false,
          appointmentDate: DateTime.now(),
          doctorGender: const DropDownItem(name: 'MALE'),
          doctors: []));
    });
    // on<GetDoctorSlots>((event, emit) async {
    //   emit(AppointmentDoctorCheckAvailabilityLoadingState());
    //   try {
    //     GetSlotsResponse? res = await appointmentRepository.getSlots(date: state.appointmentDate ?? DateTime.now(), doctorId: event.doctor.id);
    //     log(res!.data.toString());
    //     emit(AppointmentDoctorCheckAvailabilityState(
    //       doctor: event.doctor,
    //       slotList: res.data,
    //     ));
    //   } catch (e) {
    //     emit(AppointmentErrorState(error: e.toString()));
    //   }
    // });
  }
}
