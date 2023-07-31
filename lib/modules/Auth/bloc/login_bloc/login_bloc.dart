import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/common_components/services/form_submission_status.dart';
import 'package:jatya_patient_mobile/modules/Auth/model/login/login_response_model.dart';
import '../../model/login/login_request_model.dart';
import '../../services/auth_repository.dart';
import 'package:equatable/equatable.dart';
part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  LoginBloc(this._authRepository) : super(LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<LoginREInitital>((event, emit) {
      emit(state.copyWith(formStatus: const InitialFormStatus()));
    });

    on<LoginRememberMeChanged>((event, emit) {
      emit(state.copyWith(rememberMe: event.rememberMe));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        LoginResponseModel res = await _authRepository.login(
          loginRequest: LoginRequestModel(
            email: state.email,
            password: state.password,
          ),
          rememberMe: state.rememberMe,
        );
        // PatientFromUserIdResponse? res1 = await _authRepository.getPatientDetails();
        emit(LoginSuccess(res));
        // emit(state.copyWith(formStatus: FormSubmissionSuccess()));
        // if (res.response!.data.roles.contains("Patient")) {
        // } else {
        //   emit(LoginRoleFailed());
        // }
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(formStatus: FormSubmissionFailed(e.toString())));
      }
    });
  }
}
