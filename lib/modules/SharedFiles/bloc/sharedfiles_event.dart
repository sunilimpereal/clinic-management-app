part of 'sharedfiles_bloc.dart';

abstract class SharedFilesEvent extends Equatable {
  const SharedFilesEvent();
  @override
  List<Object> get props => [];
}

class SharedFilesInitialEvent extends SharedFilesEvent {
  const SharedFilesInitialEvent();
}
