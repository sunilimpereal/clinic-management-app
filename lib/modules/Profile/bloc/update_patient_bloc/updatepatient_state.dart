part of 'updatepatient_bloc.dart';

class UpdatePatientState {
  String? selectedDob;
  DropDownItem? sexValue;
  DropDownItem? maritalValue;
  String? cityValue;
  String? stateValue;
  DropDownItem? countryValue;
  DropDownItem? reportType;
  String reportDate;
  String mobileNum = "";
  String name = "";
  String email = "";
  String addressLine1 = "";
  String addressLine2 = "";
  String postalCode = "";
  int height = 0;
  int weight = 0;
  File? uploadedFile;
  bool? isUpdated;

  List<DropDownItem> sexOptions = const [
    DropDownItem(name: 'Male'),
    DropDownItem(name: 'Female'),
    DropDownItem(name: 'Third gender'),
  ];
  List<DropDownItem> maritalOptions = const [
    DropDownItem(name: "single"),
    DropDownItem(name: "married"),
    DropDownItem(name: "widowed"),
    DropDownItem(name: "divorced"),
  ];
  /*List<DropDownItem> cityOptions =
      ItemsConstants.cityItems.map((e) => DropDownItem(name: e)).toList();
  List<DropDownItem> stateOptions =
      ItemsConstants.stateItems.map((e) => DropDownItem(name: e)).toList();*/
  List<DropDownItem> countryOptions =
      ItemsConstants.countryItems.map((e) => DropDownItem(name: e)).toList();
  List<DropDownItem> reportTypeOptions =
      ItemsConstants.reportType1.map((e) => DropDownItem(name: e)).toList();

  UpdatePatientState(
      {this.selectedDob,
      this.sexValue,
      this.maritalValue,
      this.cityValue,
      this.stateValue,
      this.countryValue,
      this.mobileNum = "",
      this.name = "",
      this.email = "",
      this.addressLine1 = "",
      this.addressLine2 = "",
      this.postalCode = "",
      this.uploadedFile,
      this.reportType,
      this.reportDate = "",
      this.height = 0,
      this.weight = 0,
      this.isUpdated = false});
  UpdatePatientState copyWith({
    String? selectedDob,
    DropDownItem? sexValue,
    DropDownItem? maritalValue,
    String? cityValue,
    String? stateValue,
    DropDownItem? countryValue,
    String? mobileNum,
    String? name,
    String? email,
    String? addressLine1,
    String? addressLine2,
    String? postalCode,
    File? uploadedFile,
    DropDownItem? reportType,
    String? reportDate,
    bool? isUpdated,
    int? height,
    int? weight,
    UpdatePatientState? registerPatientState,
  }) {
    if (registerPatientState != null) {
      return UpdatePatientState(
        selectedDob: registerPatientState.selectedDob,
        sexValue: registerPatientState.sexValue,
        maritalValue: registerPatientState.maritalValue,
        cityValue: registerPatientState.cityValue,
        stateValue: registerPatientState.stateValue,
        countryValue: registerPatientState.countryValue,
        mobileNum: registerPatientState.mobileNum,
        name: registerPatientState.name,
        email: registerPatientState.email,
        addressLine1: registerPatientState.addressLine1,
        addressLine2: registerPatientState.addressLine2,
        postalCode: registerPatientState.postalCode,
        height: registerPatientState.height,
        weight: registerPatientState.weight,
        reportDate: registerPatientState.reportDate,
        reportType: registerPatientState.reportType,
        uploadedFile: registerPatientState.uploadedFile,
        isUpdated: registerPatientState.isUpdated,
      );
    }
    return UpdatePatientState(
      selectedDob: selectedDob ?? this.selectedDob,
      sexValue: sexValue ?? this.sexValue,
      maritalValue: maritalValue ?? this.maritalValue,
      cityValue: cityValue ?? this.cityValue,
      stateValue: stateValue ?? this.stateValue,
      countryValue: countryValue ?? this.countryValue,
      mobileNum: mobileNum ?? this.mobileNum,
      name: name ?? this.name,
      email: email ?? this.email,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2  ?? this.addressLine2,
      postalCode: postalCode ?? this.postalCode,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      uploadedFile: uploadedFile ?? this.uploadedFile,
      reportType: reportType ?? this.reportType,
      reportDate: reportDate ?? this.reportDate,
      isUpdated: isUpdated ?? this.isUpdated,
    );
  }
}

class UpdatePatientInitialState extends UpdatePatientState {
  UpdatePatientInitialState();
}

class UpdatePatientLoadingState extends UpdatePatientState {
  UpdatePatientLoadingState();
}

class UpdatePatientSuccessState extends UpdatePatientState {
  UpdatePatientSuccessState();
}

class UpdatePatientErrorState extends UpdatePatientState {
  final String error;
  UpdatePatientErrorState({required this.error});
}
