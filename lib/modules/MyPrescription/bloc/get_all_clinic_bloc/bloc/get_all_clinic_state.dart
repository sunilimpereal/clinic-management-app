part of 'get_all_clinic_bloc.dart';

abstract class ClinicwisePrescriptionState extends Equatable {
  const ClinicwisePrescriptionState();

  @override
  List<Object> get props => [];
}

class ClinicwiseInitial extends ClinicwisePrescriptionState {}

class ClinicwiseLoading extends ClinicwisePrescriptionState {}

class ClinicwiseSuccess extends ClinicwisePrescriptionState {
  GetAllClinicResponse getAllClinicResponse;
  ClinicwiseSuccess({required this.getAllClinicResponse});
}

class ClinicwiseFailure extends ClinicwisePrescriptionState {}
