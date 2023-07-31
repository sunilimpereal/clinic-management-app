part of 'get_prescription_clinic_wise_bloc.dart';

abstract class GetPrescriptionCliicWiseState extends Equatable {
  const GetPrescriptionCliicWiseState();

  @override
  List<Object> get props => [];
}

class GetPrescriptionCliicWiseInitial extends GetPrescriptionCliicWiseState {}

class GetPrescriptionCliicWiseLoading extends GetPrescriptionCliicWiseState {}

class GetPrescriptionCliicWiseSuccess extends GetPrescriptionCliicWiseState {
  final GetAllPrecriptionResposnse getAllPrescriptions;

  const GetPrescriptionCliicWiseSuccess({required this.getAllPrescriptions});
}

class GetPrescriptionCliicWiseFailure extends GetPrescriptionCliicWiseState {}
