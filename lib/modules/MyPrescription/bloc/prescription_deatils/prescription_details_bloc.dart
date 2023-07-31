import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:clinic_app/common_components/services/file_download_handler.dart';
import 'package:clinic_app/modules/MyPrescription/models/prescription_deatils/prescription_details.dart';
import 'package:clinic_app/modules/MyPrescription/services/prescription_services.dart';
import 'package:clinic_app/utils/SharePref.dart';
import 'package:url_launcher/url_launcher.dart';

part 'prescription_details_bloc_event.dart';
part 'prescription_details_bloc_state.dart';

class PrescriptionDetailsBlocBloc
    extends Bloc<PrescriptionDetailsBlocEvent, PrescriptionDetailsBlocState> {
  PrescriptionDetailsBlocBloc() : super(PrescriptionDetailsBlocInitial()) {
    on<GetPrescriptionDetailsEvent>((event, emit) async {
      emit(PrescriptionDetailsBlocLoading());
      PrescriptionDetails? prescriptionDetails;

      try {
        prescriptionDetails = await PrescriptionRepo
            .fetchSpecificPrescriptionsDetailsByAppointmentID(
                event.appointmentID, sharedPrefs.authToken!);
      } catch (e) {
        log(e.toString());
      }
      if (prescriptionDetails != null) {
        emit(PrescriptionDetailsBlocSuccess(prescriptionDetails));
      } else {
        emit(PrescriptionDetailsBlocFailure());
      }
    });
    on<DownloadPrescriptionDetailsEvent>((event, emit) async {
      String fileName = event.reportUrl?.split('/').last??"";

      // Trim the filename until the extension
      RegExp regExp = RegExp(r'(.*\.(pdf|jpeg|png))');
      RegExpMatch? match = regExp.firstMatch(fileName);
      if (match != null) {
        fileName = match.group(1)!;
      } else {
        // Handle cases where the URL doesn't contain a valid extension
        fileName = 'prescription.pdf';
      }
      emit(PrescriptionDownloadBlocLoading());
      String? url = event.reportUrl;
      bool isDownloaded = (url != null) &&
          await FileDownloadHandler.downloadFile(fileName, url);
      emit(isDownloaded
          ? PrescriptionDownloadBlocSuccess()
          : PrescriptionDownlaodBlocFailure());
    });
  }
}
