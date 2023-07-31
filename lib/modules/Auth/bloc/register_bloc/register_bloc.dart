import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/common_components/services/form_submission_status.dart';
import 'package:jatya_patient_mobile/modules/Auth/model/register/register_request_model.dart';
import 'package:jatya_patient_mobile/modules/Auth/model/register/register_response_model.dart';

import '../../services/auth_repository.dart';
import 'package:equatable/equatable.dart';
part 'register_state.dart';
part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;
  RegisterBloc({required this.authRepository}) : super(RegisterState()) {
    on<RegisterFirstNameChanged>((event, emit) {
      emit(state.copyWith(firstName: event.firstName));
    });
    on<RegisterLastNameChanged>((event, emit) {
      emit(state.copyWith(lastName: event.lastName));
    });
    on<RegisterEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<RegisterReInitial>((event, emit) {
      emit(state.copyWith(formStatus: const InitialFormStatus()));
    });
    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        RegisterResponse res = await authRepository.register(
          registerRequest: RegisterRequest(
            name: event.name,
            email: event.email,
            password: event.password,
          ),
        );

        emit(RegisterSuccess(otp: "", validationId: res.data.validationId));
      } catch (e) {
        emit(state.copyWith(formStatus: FormSubmissionFailed(e.toString())));
      }
    });
  }
}
