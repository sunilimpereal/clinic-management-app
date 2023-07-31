import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/utils/constants/color_konstants.dart';
import '../../../../common_components/widgets/date_picker.dart';
import '../../../../common_components/widgets/dropdown.dart';
import '../../../Auth/services/validators.dart';
import '../../../Auth/widgets/input_text_field.dart';
import '../../../Auth/widgets/phone_number_textfield.dart';
import '../../bloc/update_patient_bloc/updatepatient_bloc.dart';
import '../../models/patient/get_patient_details_response.dart';
import '../../widgets/csc_picker2.dart';

class PatientDemographicsTab extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final PatientData? patientDetails;
  const PatientDemographicsTab(
      {super.key,
      required this.formKey,
      this.patientDetails,
      required PatientData patientData});

  @override
  State<PatientDemographicsTab> createState() => _PatientDemographicsTabState();
}

class _PatientDemographicsTabState extends State<PatientDemographicsTab>
    with AutomaticKeepAliveClientMixin {
  String countryValue = "";
  String stateValue ="";
  String cityValue = "";
  String address = "";
  
  bool isDropdownOpen = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    super.build(context);
    return BlocBuilder<UpdatePatientBloc, UpdatePatientState>(
      builder: (context, state) {

        return GestureDetector(
          onTap: () {
            if (!isDropdownOpen) {
              FocusManager.instance.primaryFocus?.unfocus(); // Close keyboard
            }
            isDropdownOpen = false;
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: Form(
                key: widget.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'MOBILE#',
                                    style:
                                        TextStyle(color: Colors.blueGrey[300]),
                                  ),
                                  const TextSpan(
                                      text: ' *',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const PhoneNumberDropdownMenu(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    width: 1,
                                    height: 20,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0, bottom: 1),
                                  child: SizedBox(
                                    width: width * 0.6,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: 'Enter',
                                      ),
                                      initialValue: state.mobileNum,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      validator: (number) =>
                                          Validators.phoneValidator(number),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) => context
                                          .read<UpdatePatientBloc>()
                                          .add(UpdatePatientFormChangedEvent(
                                              mobileNum: value)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InputTextField(
                        key: const Key("name"),
                        inititalValue: state.name,
                        onChanged: (value) => context
                            .read<UpdatePatientBloc>()
                            .add(UpdatePatientFormChangedEvent(name: value)),
                        validator: (name) => Validators.nameValidator(name),
                        isMandatory: true,
                        labelText: "PATIENT NAME",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DatePicker(
                        width: MediaQuery.of(context).size.width,
                        initialDate: state.selectedDob,
                        title: "DATE OF BIRTH",
                        isMandatory: true,
                        onChanged: (date) {
                          context.read<UpdatePatientBloc>().add(
                              UpdatePatientFormChangedEvent(
                                  selectedDob: date.toString()));
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          FocusManager.instance.primaryFocus
                              ?.unfocus(); // Close keyboard
                          setState(() {
                            isDropdownOpen = true;
                          });
                        },
                        child: DropDownWidget(
                          title: 'SEX',
                          hint: 'Select Sex',
                          isMandatory: true,
                          selectedItem: state.sexValue,
                          options: state.sexOptions,
                          onChanged: (value) {
                            FocusManager.instance.primaryFocus
                                ?.unfocus(); // Close keyboard
                            context.read<UpdatePatientBloc>().add(
                                  UpdatePatientFormChangedEvent(
                                    sexValue: value,
                                  ),
                                );
                          },
                        ),
                      ),
                      InputTextField(
                        // key: !state.isUpdated! ? Key(state.email) : null,
                        inititalValue: state.email,
                        onChanged: (value) => context
                            .read<UpdatePatientBloc>()
                            .add(UpdatePatientFormChangedEvent(email: value)),
                        validator: (String? val) =>
                            Validators.emailValidator(val),
                        labelText: "EMAIL ID",
                      ),
                      GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus(); // Close keyboard
                          },
                          child: DropDownWidget(
                              title: 'MARITAL STATUS',
                              hint: 'Select',
                              selectedItem: state.maritalValue,
                              options: state.maritalOptions,
                              onChanged: (value) {
                                FocusScope.of(context).unfocus();
                                context.read<UpdatePatientBloc>().add(
                                    UpdatePatientFormChangedEvent(
                                        maritalValue: value));
                              })),
                      InputTextField(
                        key: const Key("height"),
                        inititalValue:
                            state.height != 0 ? state.height.toString() : null,
                        onChanged: (value) => context
                            .read<UpdatePatientBloc>()
                            .add(UpdatePatientFormChangedEvent(
                                height: int.parse(value))),
                        validator: (height) =>
                            Validators.heightValidator(height),
                        keyboardType: TextInputType.number,
                        labelText: "HEIGHT",
                        suffix: const Text("Cm",
                            style:
                                TextStyle(color: ColorKonstants.primaryColor)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputTextField(
                        key: const Key("weight"),
                        inititalValue:
                            state.weight != 0 ? state.weight.toString() : null,
                        onChanged: (value) => context
                            .read<UpdatePatientBloc>()
                            .add(UpdatePatientFormChangedEvent(
                                weight: int.parse(value))),
                        validator: (weight) =>
                            Validators.weightValidator(weight),
                        keyboardType: TextInputType.number,
                        labelText: "WEIGHT",
                        suffix: const Text(
                          "Kg",
                          style: TextStyle(color: ColorKonstants.primaryColor),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputTextField(
                        // key: !state.isUpdated! ? Key(state.address + "1") : null,
                        inititalValue: state.addressLine1,
                        onChanged: (value) => context
                            .read<UpdatePatientBloc>()
                            .add(UpdatePatientFormChangedEvent(
                                addressLine1: value)),
                        validator: (String? val) {
                          return null;
                        },
                        labelText: "ADDRESS LINE 1",
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      InputTextField(
                        // key: !state.isUpdated! ? Key(state.address) : null,
                        inititalValue: state.addressLine2,
                        onChanged: (value) => context
                            .read<UpdatePatientBloc>()
                            .add(UpdatePatientFormChangedEvent(
                                addressLine2: value)),
                        validator: (String? val) {
                          return null;
                        },
                        labelText: "ADDRESS LINE 2",
                      ),
                      /*DropDownWidget(
                          title: 'CITY',
                          hint: 'Select',
                          selectedItem: state.cityValue,
                          options: state.cityOptions,
                          onChanged: (value) => context
                              .read<UpdatePatientBloc>()
                              .add(UpdatePatientFormChangedEvent(
                                  cityValue: value))),*/
                      /*DropDownWidget(
                          title: 'STATE',
                          hint: 'Select',
                          selectedItem: state.stateValue,
                          options: state.stateOptions,
                          onChanged: (value) => context
                              .read<UpdatePatientBloc>()
                              .add(UpdatePatientFormChangedEvent(
                                  stateValue: value))),*/
                      CSCPicker(
                        layout: Layout.vertical,
                        showStates: true,
                        showCities: true,
                        flagState: CountryFlag.DISABLE,
                        countrySearchPlaceholder: "Country",
                        stateSearchPlaceholder: "State",
                        citySearchPlaceholder: "City",
                        ///labels for dropdown
                        countryDropdownLabel: "*Country",
                        stateDropdownLabel: "${state.stateValue}",
                        cityDropdownLabel: "${state.cityValue}",
                        defaultCountry: CscCountry.India,
                        disableCountry: true,
                        selectedItemStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        dropdownHeadingStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                        dropdownItemStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),

                        ///Dialog box radius [OPTIONAL PARAMETER]
                        dropdownDialogRadius: 10.0,

                        ///triggers once country selected in dropdown
                        onCountryChanged: (value) {
                          setState(() {
                            ///store value in country variable
                            countryValue = value??"";
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            ///store value in state variable
                            stateValue = value??"";
                            context.read<UpdatePatientBloc>().add(
                                UpdatePatientFormChangedEvent(stateValue: value));
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            cityValue=value??"";
                            context.read<UpdatePatientBloc>().add(
                              UpdatePatientFormChangedEvent(cityValue: value),
                            );
                          });
                        },
                      ),
                      InputTextField(
                        // key: !state.isUpdated! ? Key(state.postalCode) : null,
                        inititalValue: state.postalCode,
                        onChanged: (value) => context
                            .read<UpdatePatientBloc>()
                            .add(UpdatePatientFormChangedEvent(
                                postalCode: value)),
                        validator: (String? val) {
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        labelText: "ZIP/Postal Code",
                      ),
                      const SizedBox(
                        height: 60,
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
