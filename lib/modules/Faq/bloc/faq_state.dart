part of 'faq_bloc.dart';

abstract class FaqState extends Equatable {
  const FaqState();

  @override
  List<Object> get props => [];
}

class FaqInitial extends FaqState {}

class FaqLoading extends FaqState {}

class FaqLoadingSuccess extends FaqState {
  final List<FAQ> response;
  const FaqLoadingSuccess({required this.response});
}

class FaqLoadingFailed extends FaqState {}
