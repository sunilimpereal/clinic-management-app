import 'package:clinic_app/modules/search/models/clinic_response.dart';
import 'package:clinic_app/modules/search/models/doctor_response.dart';
import 'package:clinic_app/modules/search/models/medicine_response.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<GetDoctorsData> doctors;
  final List<GetMedicineData> medicines;
  final List<GetClinicData> clinics;

  SearchLoadedState({required this.doctors, required this.medicines, required this.clinics});
}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState({required this.message});
}