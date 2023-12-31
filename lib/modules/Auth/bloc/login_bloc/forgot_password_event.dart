part of '../forgot_password_bloc/forgot_password_bloc.dart';

class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends ForgotPasswordEvent {
  final String name;
  const NameChanged({required this.name});

  @override
  List<Object> get props => [];
}

class EmailChanged extends ForgotPasswordEvent {
  final String email;
  const EmailChanged({required this.email});

  @override
  List<Object> get props => [];
}

class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  final String? email;
  final String? phone;
  const ForgotPasswordSubmitted({this.email, this.phone});

  @override
  List<Object> get props => [];
}

class ForgotPasswordReinital extends ForgotPasswordEvent {
  const ForgotPasswordReinital();

  @override
  List<Object> get props => [];
}
