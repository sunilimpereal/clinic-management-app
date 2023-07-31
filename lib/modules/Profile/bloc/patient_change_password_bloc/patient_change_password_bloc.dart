import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/patient_change_password_request_model.dart';
import '../../models/patient_update_response_model.dart';
import '../../services/update_patient_repo.dart';

class PatientChangePassEvent {
  final String userId;
  final PatientChangePassRequestModel PatientChangePassRequest;

  PatientChangePassEvent({
    required this.userId,
    required this.PatientChangePassRequest,
  });
}

abstract class PatientChangePassState {}

class PatientChangePassInitialState extends PatientChangePassState {}

class PatientChangePassLoadingState extends PatientChangePassState {}

class PatientChangePassSuccessState extends PatientChangePassState {
  final PatientUpdateResponseModel PatienttionistUpdateResponseModel;

  PatientChangePassSuccessState(
      {required this.PatienttionistUpdateResponseModel});
}

class PatientChangePassErrorState extends PatientChangePassState {
  final String err;

  PatientChangePassErrorState({required this.err});
}

class PatientChangePassBloc
    extends Bloc<PatientChangePassEvent, PatientChangePassState> {
  PatientChangePassBloc() : super((PatientChangePassInitialState())) {
    on<PatientChangePassEvent>(
      (event, emit) async {
        emit(PatientChangePassLoadingState());

        try {
          UpdatePatienttionistPasswordService updatePass =
              UpdatePatienttionistPasswordService();
          PatientUpdateResponseModel? updateResp =
              await updatePass.putUpdatePatientPassword(
                  userId: event.userId,
                  recepChangePassRequestModel: event.PatientChangePassRequest);

          if (updateResp!.data != null) {
            if (updateResp.status == 200) {
              log("status 200");
              emit(PatientChangePassSuccessState(
                  PatienttionistUpdateResponseModel: updateResp));
            } else {
              emit(PatientChangePassErrorState(err: "Some Error Occured!"));
            }
          } else {
            if (updateResp.status != 200) {
              emit(PatientChangePassErrorState(err: "Something Went Wrong!"));
            } else {
              emit(PatientChangePassErrorState(err: "Something Went Wrong!"));
            }
          }
        } catch (e) {
          emit(PatientChangePassErrorState(err: e.toString()));
        }
      },
    );
  }
}
