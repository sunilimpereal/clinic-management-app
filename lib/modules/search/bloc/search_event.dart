abstract class SearchEvent {}

class SearchEverthingEvent extends SearchEvent {
  final String query;

  SearchEverthingEvent({required this.query});
}

class SearchDoctorEvent extends SearchEvent {
  final String query;

  SearchDoctorEvent({required this.query});
}

class SearchClinicEvent extends SearchEvent {
  final String query;

  SearchClinicEvent({required this.query});
}

class SearchMedicineEvent extends SearchEvent {
  final String query;

  SearchMedicineEvent({required this.query});
}