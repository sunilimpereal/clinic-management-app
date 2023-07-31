import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'welcomepopup_bloc_event.dart';
part 'welcomepopup_bloc_state.dart';

class WelcomepopupBlocBloc extends Bloc<WelcomepopupBlocEvent, WelcomepopupBlocState> {
  WelcomepopupBlocBloc() : super(WelcomepopupBlocInitial()) {
    on<WelcomepopupBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
