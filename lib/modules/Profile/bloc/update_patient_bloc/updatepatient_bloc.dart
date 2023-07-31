import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/modules/Profile/models/patient/get_patient_details_response.dart';
import 'package:jatya_patient_mobile/modules/Profile/services/patient_repositroy.dart';
import 'package:jatya_patient_mobile/utils/SharePref.dart';

import '../../../../common_components/widgets/dropdown.dart';
import '../../../../utils/constants/items_konstants.dart';
import '../../models/update_patient_model/patient_patch_request_model.dart';
import '../../models/update_patient_model/user_put_request_model.dart';

part 'updatepatient_event.dart';
part 'updatepatient_state.dart';

class UpdatePatientBloc extends Bloc<UpdatePatientEvent, UpdatePatientState> {
  UpdatePatientBloc() : super(UpdatePatientState()) {
    on<UpdatePatientInitialFillEvent>((event, emit) async {
      String phone;
      if (event.patientData.userPatientData.phoneNumber?.contains("+91") ??
          false) {
        print("got+91");
        phone = event.patientData.userPatientData.phoneNumber
                ?.replaceAll(" ", "")
                .substring(3) ??
            '';
      } else {
        print("not +91");
        phone = event.patientData.userPatientData.phoneNumber ?? '';
      }
      emit(UpdatePatientState(
        selectedDob: event.patientData.userPatientData.dateOfBirth?.toString(),
        sexValue: DropDownItem(
            name: event.patientData.userPatientData.gender.toString()),
        maritalValue: event.patientData.patient.maritalStatus != null
            ? DropDownItem(name: event.patientData.patient.maritalStatus!)
            : null,
       /* cityValue: event.patientData.userPatientData.city != null
            ? DropDownItem(name: event.patientData.userPatientData.city!)
            : null,
        stateValue: event.patientData.userPatientData.state != null
            ? DropDownItem(name: event.patientData.userPatientData.state!)
            : null,*/
        countryValue: event.patientData.userPatientData.country != null
            ? DropDownItem(name: event.patientData.userPatientData.country!)
            : null,
        stateValue: event.patientData.userPatientData.state,
        cityValue: event.patientData.userPatientData.city,
        mobileNum: phone,
        height: event.patientData.patient.height ?? 0,
        weight: event.patientData.patient.weight ?? 0,
        name: event.patientData.userPatientData.name,
        email: event.patientData.userPatientData.email,
        addressLine1: event.patientData.userPatientData.addressLine1 ?? '',
        addressLine2: event.patientData.userPatientData.addressLine2 ?? '',
        postalCode: event.patientData.userPatientData.pinCode ?? '',
        reportDate: '',
        reportType: null,
      ));
    });
    on<UpdatePatientFormChangedEvent>((event, emit) {
      emit(state.copyWith(
        selectedDob: event.selectedDob,
        sexValue: event.sexValue,
        maritalValue: event.maritalValue,
        cityValue: event.cityValue,
        stateValue: event.stateValue,
        countryValue: event.countryValue,
        mobileNum: event.mobileNum,
        name: event.name,
        email: event.email,
        addressLine1: event.addressLine1,
        addressLine2: event.addressLine2,
        postalCode: event.postalCode,
        height: event.height,
        weight: event.weight,
        reportDate: event.reportDate,
        reportType: event.reportType,
        isUpdated: true,
      ));
    });
    on<UpdatePatientSubmittedEvent>((event, emit) async {
      String phone;
      if (state.mobileNum.contains("+91")) {
        log("+91 is present");
        phone = state.mobileNum;
      } else {
        phone = "+91${state.mobileNum}";
      }
      UserPutRequest userPutRequest = UserPutRequest(
        name: state.name,
        phoneNumber: phone,
        address: "${state.addressLine1} ${state.addressLine2}".trim(),
        city: state.cityValue ?? '',
        state: state.stateValue ?? '',
        country: state.countryValue?.name ?? '',
        pinCode: state.postalCode,
        dateOfBirth: DateTime.parse(state.selectedDob!),
        // gender: state.sexValue?.name.toUpperCase().replaceAll(" ", "") ?? '',
      );
      PatientPatchRequest createPatientRequest = PatientPatchRequest(
          maritalStatus: state.maritalValue?.name.toUpperCase() ?? '',
          height: state.height,
          weight: state.weight,
          isArchived: true);
      try {
        emit(UpdatePatientLoadingState());
        await PatientRepository().putUser(
            userId: sharedPrefs.id ?? '', userPutRequest: userPutRequest);
        await PatientRepository().patchPatient(
            patientId: sharedPrefs.patientId ?? '',
            patientPatchRequest: createPatientRequest);

        emit(UpdatePatientSuccessState());
      } catch (e) {
        emit(UpdatePatientErrorState(error: "Failed to create User $e"));
      }
    });

    on<UpdatePatientInitialEvent>((event, emit) {});
    on<UpdatePatientGetEvent>((event, emit) {});
  }
}
