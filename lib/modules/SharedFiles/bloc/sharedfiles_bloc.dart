import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/modules/SharedFiles/models/sharedfiles_model.dart';

import '../services/sharedfiles_repo.dart';

part 'sharedfiles_event.dart';
part 'sharedfiles_state.dart';

class SharedFilesBloc extends Bloc<SharedFilesEvent, SharedFilesState> {
  SharedFilesBloc() : super(const SharedFilesState()) {
    on<SharedFilesInitialEvent>((event, emit) async {
      emit(SharedFileSloadingState());
      try {
        GetSharedFilesResponse? res = await SharedFilesRepository().getSharedFilesofPatient();
        if (res != null) {
          emit(SharedFilesSuccessState(list: res));
        } else {
          emit(SharedFileErrorState(error: "Something went wrong"));
        }
      } catch (e) {
        emit(SharedFileErrorState(error: e.toString()));
      }
      
    });
  }
}
