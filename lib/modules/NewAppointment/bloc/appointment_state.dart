part of 'appointment_bloc.dart';

class AppointmentState {
  DropDownItem? speciality;
  int range;
  DateTime? appointmentDate;
  bool isEmergency;
  DropDownItem? doctorGender;
  List<AvailableDoctor>? doctors;
  FormSubmissionStatus formStatus;

  List<DropDownItem> genderOptions = const [
    DropDownItem(name: 'MALE'),
    DropDownItem(name: 'FEMALE'),
    DropDownItem(name: 'THIRDGENDER'),
  ];
  List<DropDownItem> specialityOptions = [];

  AppointmentState({
    this.speciality = const DropDownItem(name: 'Urologist', id: '1'),
    this.range = 4,
    this.doctorGender = const DropDownItem(name: 'MALE'),
    this.isEmergency = false,
    this.appointmentDate,
    this.doctors,
    this.formStatus = const InitialFormStatus(),
    this.specialityOptions = const [DropDownItem(name: 'Urologist', id: '1')],
  });

  @override
  List<Object> get props => [];

  AppointmentState copyWith({
    DropDownItem? speciality,
    int? range,
    DateTime? appointmentDate,
    bool? isEmergency,
    DropDownItem? doctorGender,
    List<AvailableDoctor>? doctors,
    FormSubmissionStatus? formStatus,
    List<DropDownItem>? specialityOptions
  }) {
    return AppointmentState(
      speciality: speciality ?? this.speciality,
      range: range ?? this.range,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      isEmergency: isEmergency ?? this.isEmergency,
      doctorGender: doctorGender ?? this.doctorGender,
      doctors: doctors ?? this.doctors,
      formStatus: formStatus ?? this.formStatus,
      specialityOptions: specialityOptions ?? this.specialityOptions,
    );
  }
}

class AppointmentLoading extends AppointmentState {}

class AppointmentShowAvailableDoctors extends AppointmentState {
  AppointmentShowAvailableDoctors();
}

class AppointmentDoctorSlotEmpty extends AppointmentState {}

class AppointmentDoctorCheckAvailabilityState extends AppointmentState {
  final List<SlotDatum> slotList;
  final Doctor doctor;
  AppointmentDoctorCheckAvailabilityState({
    required this.slotList,
    required this.doctor,
    super.appointmentDate,
    super.doctorGender,
    super.doctors,
    super.formStatus,
    super.isEmergency,
    super.range,
    super.speciality,
  });
}

class AppointmentDoctorCheckAvailabilityLoadingState extends AppointmentState {
  AppointmentDoctorCheckAvailabilityLoadingState(
      {super.appointmentDate, super.doctorGender, super.doctors, super.formStatus, super.isEmergency, super.range, super.speciality});
}

class AppointmentErrorState extends AppointmentState {
  String error;
  AppointmentErrorState(
      {required this.error,
      super.appointmentDate,
      super.doctorGender,
      super.doctors,
      super.formStatus,
      super.isEmergency,
      super.range,
      super.speciality});
}
