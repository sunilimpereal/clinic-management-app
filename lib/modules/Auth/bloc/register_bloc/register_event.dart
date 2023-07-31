part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterFirstNameChanged extends RegisterEvent {
  final String firstName;
  const RegisterFirstNameChanged({required this.firstName});

  @override
  List<Object> get props => [firstName];
}

class RegisterLastNameChanged extends RegisterEvent {
  final String lastName;
  const RegisterLastNameChanged({required this.lastName});

  @override
  List<Object> get props => [lastName];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;
  const RegisterEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  const RegisterPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class RegisterConfPasswordChanged extends RegisterEvent {
  final String confpassword;
  const RegisterConfPasswordChanged({required this.confpassword});

  @override
  List<Object> get props => [confpassword];
}

class RegisterSubmitted extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  const RegisterSubmitted({
    required this.email,
    required this.name,
    required this.password,
  });
}

class RegisterReInitial extends RegisterEvent {
  const RegisterReInitial();
}
