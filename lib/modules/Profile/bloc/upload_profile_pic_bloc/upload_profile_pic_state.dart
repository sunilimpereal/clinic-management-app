part of 'upload_profile_pic_bloc.dart';

class UploadProfilePicState {
  final XFile? profileImage;
  const UploadProfilePicState({this.profileImage});
  UploadProfilePicState copyWith({XFile? image}) {
    return UploadProfilePicState(profileImage: image);
  }
}

class UploadProfilePicLoadingState extends UploadProfilePicState {}

class UploadProfilePicSuccessState extends UploadProfilePicState {}

class UploadProfilePicFailedState extends UploadProfilePicState {
  final String error;
  UploadProfilePicFailedState({required this.error});
}
