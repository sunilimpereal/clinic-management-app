part of 'mediline_search_bloc.dart';

class MedilineSearchState {
  DateTime? selectedDate;
  List<Clinic>? clinicList;
  MedilineSearchState({this.selectedDate, this.clinicList});
  MedilineSearchState copyWith({
    DateTime? selectedDate,
    List<Clinic>? clinicList,
  }) {
    return MedilineSearchState(
      selectedDate: selectedDate ?? this.selectedDate,
      clinicList: clinicList ?? this.clinicList,
    );
  }
}

class MedilineSearchloadingState extends MedilineSearchState {}

class MedilineSearchErrorState extends MedilineSearchState {
  final String error;

  MedilineSearchErrorState({required this.error});
}

class MedilineSearchResultState extends MedilineSearchState {
  @override
  final List<AppointmentDatum> appointmentList;
  MedilineSearchResultState({
    required this.appointmentList,
  });
}
