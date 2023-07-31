import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic_app/modules/search/bloc/search_event.dart';
import 'package:clinic_app/modules/search/bloc/search_state.dart';
import 'package:clinic_app/modules/search/services/search_repo.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<SearchEverthingEvent>(searchEverything);
    on<SearchDoctorEvent>(searchDoctor);
    on<SearchClinicEvent>(searchClinic);
    on<SearchMedicineEvent>(searchMedicine);
  }

  final SearchServices _searchServices = SearchServices();

  void searchEverything(
      SearchEverthingEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    try {
      var doctors = await _searchServices.getDoctorsViaName(event.query);
      var medicines = await _searchServices.getMedicineViaName(event.query);
      var clinics = await _searchServices.getClinicViaName(event.query);
      emit(SearchLoadedState(
          doctors: doctors?.data ?? [],
          medicines: medicines?.data ?? [],
          clinics: clinics?.data ?? []));
    } catch (e) {
      emit(SearchErrorState(message: e.toString()));
    }
  }

  void searchDoctor(SearchDoctorEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    try {
      var doctors = await _searchServices.getDoctorsViaName(event.query);
      emit(SearchLoadedState(
          doctors: doctors?.data ?? [], medicines: [], clinics: []));
    } catch (e) {
      emit(SearchErrorState(message: e.toString()));
    }
  }

  void searchClinic(SearchClinicEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    try {
      var clinics = await _searchServices.getClinicViaName(event.query);
      emit(SearchLoadedState(
          doctors: [], medicines: [], clinics: clinics?.data ?? []));
    } catch (e) {
      emit(SearchErrorState(message: e.toString()));
    }
  }

  void searchMedicine(
      SearchMedicineEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    try {
      var medicines = await _searchServices.getMedicineViaName(event.query);
      emit(SearchLoadedState(
          doctors: [], medicines: medicines?.data ?? [], clinics: []));
    } catch (e) {
      emit(SearchErrorState(message: e.toString()));
    }
  }

  
}
