part of 'allergy_bloc.dart';

abstract class AllergyEvent extends Equatable {
  const AllergyEvent();
  @override
  List<Object> get props => [];
}

class AllergyInitialEvent extends AllergyEvent {
  const AllergyInitialEvent();
}

class AllergyGetEvent extends AllergyEvent {
  const AllergyGetEvent();
}
