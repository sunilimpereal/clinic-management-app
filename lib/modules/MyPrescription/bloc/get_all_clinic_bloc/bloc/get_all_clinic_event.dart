part of 'get_all_clinic_bloc.dart';

abstract class ClinicwisePrescriptionEvent extends Equatable {
  const ClinicwisePrescriptionEvent();

  @override
  List<Object> get props => [];
}

class GetAllClinicEvents extends ClinicwisePrescriptionEvent {}
