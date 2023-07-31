part of 'get_prescription_clinic_wise_bloc.dart';

abstract class GetPrescriptionClinicWiseEvent extends Equatable {
  const GetPrescriptionClinicWiseEvent();

  @override
  List<Object> get props => [];
}

class GetAllMyPrescriptionByClinicIDEvent
    extends GetPrescriptionClinicWiseEvent {
  final String clinicId;
  const GetAllMyPrescriptionByClinicIDEvent(this.clinicId);
}
