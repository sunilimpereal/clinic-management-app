part of 'mediline_bloc.dart';

class MedilineState extends Equatable {
  final DateTime? selectedDate;
  final List<AppointmentDatum>? appointmentList;
  final List<Clinic>? clinicList;
  final bool isEnd;
  const MedilineState({this.appointmentList, this.isEnd = false, this.clinicList, this.selectedDate});

  @override
  List<Object> get props => [];
}

class MedilineLoadingState extends MedilineState {}

class MedilineSuccessState extends MedilineState {
  const MedilineSuccessState({super.selectedDate, super.appointmentList, super.clinicList, super.isEnd});

  MedilineSuccessState copyWith({
    DateTime? selectedDate,
    List<AppointmentDatum>? appointmentList,
    List<Clinic>? clinicList,
  }) {
    return MedilineSuccessState(
      selectedDate: selectedDate ?? this.selectedDate,
      appointmentList: appointmentList ?? this.appointmentList,
      clinicList: clinicList ?? this.clinicList,
    );
  }
}

class MedilineErrorState extends MedilineState {
  final String error;

  const MedilineErrorState({required this.error});
}
