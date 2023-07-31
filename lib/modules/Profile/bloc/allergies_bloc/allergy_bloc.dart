import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'allergy_event.dart';
part 'allergy_state.dart';

class AllergyBloc extends Bloc<AllergyEvent, AllergyState> {
  AllergyBloc() : super(const AllergyState()) {
    on<AllergyInitialEvent>((event, emit) {});
    on<AllergyGetEvent>((event, emit) {});
  }
}
