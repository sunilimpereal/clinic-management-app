part of 'my_prescription_bloc.dart';

abstract class MyPrescriptionState extends Equatable {
  const MyPrescriptionState();

  @override
  List<Object> get props => [];
}

class MyPrescriptionInitial extends MyPrescriptionState {}

class MyPrescriptionBlocloading extends MyPrescriptionState {}

class MyPrescriptionBlocSuccess extends MyPrescriptionState {
  final List<GetAllPrescriptionData>? getAllPrescriptions;
  final List<Clinic>? clinicList;

  const MyPrescriptionBlocSuccess({this.clinicList,this.getAllPrescriptions});

  MyPrescriptionBlocSuccess copyWith({
    List<GetAllPrescriptionData>? getAllPrescriptions,
    List<Clinic>? clinicList,
  }) {
    return MyPrescriptionBlocSuccess(
      getAllPrescriptions:  getAllPrescriptions ?? this. getAllPrescriptions,
      clinicList: clinicList ?? this.clinicList,
    );
  }
}

class MyPrescriptionBlocFailure extends MyPrescriptionState {}
