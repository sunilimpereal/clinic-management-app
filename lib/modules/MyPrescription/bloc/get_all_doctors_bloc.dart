import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic_app/modules/MyPrescription/services/prescription_services.dart';
import 'package:clinic_app/modules/search/models/doctor_response.dart';

class GetAllDoctorsEvent {}

abstract class GetAllDoctorsState {}

class GetAllDoctorsLoadingState extends GetAllDoctorsState {}

class GetAllDoctorsSuccessState extends GetAllDoctorsState {
  final List<GetDoctorsData> doctors;
  GetAllDoctorsSuccessState({required this.doctors});
}

class GetAllDoctorsErrorState extends GetAllDoctorsState {
  final String message;
  GetAllDoctorsErrorState({required this.message});
}

class GetAllDoctorsBloc extends Bloc<GetAllDoctorsEvent, GetAllDoctorsState> {
  GetAllDoctorsBloc() : super(GetAllDoctorsLoadingState()) {
    on<GetAllDoctorsEvent>(_getAllDoctors);
  }

  void _getAllDoctors(
      GetAllDoctorsEvent event, Emitter<GetAllDoctorsState> emit) async {
    emit(GetAllDoctorsLoadingState());
    try {
      List<GetDoctorsData> doctors = await PrescriptionRepo().getDoctors();
      emit(GetAllDoctorsSuccessState(doctors: doctors));
    } catch (e) {
      emit(GetAllDoctorsErrorState(message: e.toString()));
    }
  }
}
