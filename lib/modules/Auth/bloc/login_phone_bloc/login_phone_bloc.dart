import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:clinic_app/modules/Auth/model/login/login_phone_request_model.dart';
import 'package:clinic_app/modules/Auth/model/login/login_phone_response_model.dart';
import 'package:clinic_app/modules/Auth/model/login/login_response_model.dart';
import 'package:clinic_app/modules/Auth/model/login/mfa_phone_request.dart';
import 'package:clinic_app/modules/Auth/services/auth_repository.dart';
import '../../../../common_components/services/form_submission_status.dart';
import 'login_phone_state.dart';
part 'login_phone_event.dart';

class LoginPhoneBloc extends Bloc<LoginPhoneEvent, LoginPhoneState> {
  final AuthRepository _authRepository;
  LoginPhoneBloc(this._authRepository) : super(LoginPhoneInitial()) {
    on<LoginPhoneNumberChanged>((event, emit) {
      emit(state.copyWith(phoneNumber: event.phoneNumber));
    });
    on<LoginPhoneReinitial>((event, emit) {
      emit(LoginPhoneInitial());
    });
    on<LoginPhoneSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        LoginPhoneResponse res = await _authRepository.loginPhone(
          loginPhoneRequestModel:
              LoginPhoneRequestModel(phoneNumber: "+91 ${state.phoneNumber}"),
        );
        emit(LoginPhoneSuccess(
            //otp: res.data.otp,
            validationId: res.data.validationId));
      } catch (e) {
        emit(state.copyWith(formStatus: FormSubmissionFailed(e.toString())));
      }
    });

    on<LoginPhoneOTPSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        LoginResponseModel res = await _authRepository.mfaPhone(
          mfaPhoneRequest: MfaPhoneRequest(
            validationId: event.validationId,
            otp: event.otp,
          ),
        );
        emit(LoginPhoneOTPSuccess(res));
      } catch (e) {
        emit(
          state.copyWith(
            formStatus: FormSubmissionFailed(
              e.toString(),
            ),
          ),
        );
      }
    });
  }
}
