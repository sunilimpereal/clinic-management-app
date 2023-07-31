import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/modules/Faq/models/faq_model.dart';
import 'package:jatya_patient_mobile/modules/Faq/services/faq_services.dart';

part 'faq_event.dart';
part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  FaqBloc() : super(FaqInitial()) {
    on<GetAllFAQsEvent>(_getAllFAQs);
  }

  FutureOr<void> _getAllFAQs(
      GetAllFAQsEvent event, Emitter<FaqState> emit) async {
    emit(FaqLoading());
    try {
      List<FAQ> faqs = await FaqService.getAllFAQs() ?? [];
      emit(FaqLoadingSuccess(response: faqs));
    } catch (e) {
      log(e.toString());
      emit(FaqLoadingFailed());
    }
  }
}
