import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic_app/modules/Mediline/models/get_appointmens_response.dart';
import 'package:clinic_app/modules/Mediline/services/mediline_repository.dart';

import '../../../NewAppointment/model/get_clinic_detail_response.dart';

part 'mediline_search_event.dart';
part 'mediline_search_state.dart';

class MedilineSearchBloc
    extends Bloc<MedilineSearchEvent, MedilineSearchState> {
  MedilineSearchBloc() : super(MedilineSearchState()) {
    on<MedilineGetSearchEvent>((event, emit) async {
      emit(MedilineSearchloadingState());
      try {
        GetAppointmentResponse? res = await MedilineRepository()
            .getAppointmentsSearch(search: event.searchQuery);
        print(event.searchQuery.toString());
        if (res != null) {
          if (res.data.isNotEmpty) {
            emit(MedilineSearchResultState(appointmentList: res.data));
          } else {
            emit(MedilineSearchErrorState(error: "No Resultssss Found"));
          }
        } else {
          emit(MedilineSearchErrorState(error: "Something Went Wrong!"));
        }
      } catch (e) {
        log("we are in catch");
        emit(MedilineSearchErrorState(error: "No Results Found"));
      }
    });
    // on<MedilineGetSearchEvent>((event, emit) async {});
  }
}
