import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:clinic_app/common_components/services/form_submission_status.dart';
import 'package:clinic_app/modules/Auth/model/forgot_password/forgot_password_request_model.dart';
import 'package:clinic_app/modules/Auth/model/forgot_password/forgot_password_response.dart';
import 'package:clinic_app/modules/Auth/services/auth_repository.dart';

part '../login_bloc/forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository authRepository;
  ForgotPasswordBloc({required this.authRepository})
      : super(ForgotPasswordInitial()) {
    on<NameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<ForgotPasswordReinital>((event, emit) {
      emit(state.copyWith(formStatus: const InitialFormStatus()));
    });
    on<ForgotPasswordSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      if (event.email == null || event.email!.isEmpty) {
        emit(state.copyWith(
            formStatus: FormSubmissionFailed(
          'OTP on phone is not supported yet.',
        )));
        return;
      }
      try {
        ForgotPasswordResponse? res = await authRepository.forgotPassword(
          forgotPasswordRequest: ForgotPasswordRequest(
            name: "Test Name",
            email: state.email,
          ),
        );
        emit(ForgotPasswordSuccess(
            email: state.email,
            name: state.name,
            // otp: res.response!.data.otp,
            validationId: res.data.validationId));
      } catch (e) {
        emit(state.copyWith(formStatus: FormSubmissionFailed(e.toString())));
      }
    });
  }
}
