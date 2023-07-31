import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clinic_app/utils/SharePref.dart';

import '../../services/upload_profile_repository.dart';
part 'upload_profile_pic_event.dart';
part 'upload_profile_pic_state.dart';

class UploadProfilePicBloc
    extends Bloc<UploadProfilePicEvent, UploadProfilePicState> {
  UploadProfilePicBloc() : super(const UploadProfilePicState()) {
    on<onSelectProfileImageEvent>((_onSelectMultipleImages));
    on<onUnSelectProfileImageEvent>((_onUnSelectMultipleImages));
  }
  Future<void> _onSelectMultipleImages(onSelectProfileImageEvent event,
      Emitter<UploadProfilePicState> emit) async {
    emit(UploadProfilePicLoadingState());
    try {
      final file = File(event.profileImage!.path);
      UploadProfileRepository uploadProfile = UploadProfileRepository();
      final resp = await uploadProfile.uploadReportFile(file: file);
      log('resp of upload= $resp');
      sharedPrefs.setProfilePic(resp.toString());
      emit(UploadProfilePicSuccessState());
      // emit(state.copyWith(image: event.profileImage));
    } catch (e) {
      emit(UploadProfilePicFailedState(error: e.toString()));
    }
  }

  Future<void> _onUnSelectMultipleImages(onUnSelectProfileImageEvent event,
      Emitter<UploadProfilePicState> emit) async {
    emit(state.copyWith(image: null));
  }
}
