part of 'sharedfiles_bloc.dart';

class SharedFilesState {
  const SharedFilesState();
}

class SharedFileSloadingState extends SharedFilesState {}

class SharedFilesSuccessState extends SharedFilesState {
  GetSharedFilesResponse list;
  SharedFilesSuccessState({required this.list});
}

class SharedFileErrorState extends SharedFilesState {
  String error;
  SharedFileErrorState({required this.error});
}
