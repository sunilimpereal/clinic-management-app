import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic_app/modules/MyJatya/screens/MyJatya.dart';
import 'package:clinic_app/modules/Profile/bloc/patient_bloc/patient_bloc.dart';
import 'package:clinic_app/modules/Profile/bloc/update_patient_bloc/updatepatient_bloc.dart';
import 'package:clinic_app/modules/Profile/models/patient/get_patient_details_response.dart';
import 'package:clinic_app/modules/Profile/screens/patient_update_screen_tabs/allergies_tab.dart';
import 'package:clinic_app/modules/Profile/screens/patient_update_screen_tabs/demographic_tab.dart';
import 'package:clinic_app/modules/Profile/screens/patient_update_screen_tabs/previous_reports_tab.dart';
import 'package:clinic_app/modules/Profile/screens/patient_update_screen_tabs/vaccination_tab.dart';
import 'package:clinic_app/modules/Profile/services/allergies_respository.dart';
import 'package:clinic_app/modules/Profile/widgets/callus_popup_dialog.dart';

import '../../../utils/constants/color_konstants.dart';
import '../models/allergies/post_allergy_request.dart';

class PatientUpdateDetails extends StatefulWidget {
  final PatientData patientData;
  final int? tab;
  const PatientUpdateDetails(
      {super.key, this.tab, required this.patientData} //required this.allergy
      );
  @override
  State<PatientUpdateDetails> createState() => _PatientUpdateDetailsState();
}

class _PatientUpdateDetailsState extends State<PatientUpdateDetails> {
  late Allergies allerges;
  @override
  void initState() {
    allerges = Allergies(
      patientId: widget.patientData.patient.id,
      medicineAllergies: [],
      foodAllergies: [],
      petAllergies: [],
      other: "",
    );

    super.initState();
  }

  List<GlobalKey<FormState>> formKeys = [GlobalKey<FormState>()];

  bool submitForm() {
    for (var i = 0; i < formKeys.length; i++) {
      if (!(formKeys[i].currentState?.validate() ?? false)) {
        return false;
      }
    }
    return true;
  }

  bool isAllergyEdited = false;

  @override
  Widget build(BuildContext context) {
    //super.build(context);
    return BlocListener<UpdatePatientBloc, UpdatePatientState>(
      listener: (context, state) {
        if (state is UpdatePatientSuccessState) {
          showDialog(
            context: context,
            builder: (context) => Center(
              child: ProfilePopupDialog(
                height: 280,
                iconBackColor: const Color(0xff2CD889),
                backColor: Colors.white,
                side: false,
                icon: const Icon(
                  Icons.done,
                  color: Colors.white,
                ),
                child: successPopupUi(context),
              ),
            ),
          );
        } else if (state is UpdatePatientErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      child: DefaultTabController(
        length: 4,
        initialIndex: widget.tab ?? 0,
        child: Scaffold(
          appBar: customAppBar(),
          body: tabBarView(),
        ),
      ),
    );
  }

  Widget successPopupUi(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Profile updated successfully.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          const Text(
            "You may revisit your profile details in your app and make changes later. Let’s now start exploring the app!",
            style: TextStyle(height: 1.4),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyJatya(),
                  ));
            },
            child: Center(
              child: Container(
                width: 220,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xff007BC7),
                ),
                child: Center(
                  child: Text(
                    'OK, Proceed',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: ColorKonstants.whiteBG,
                    ),
                  ),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Center(
              child: Text(
                "Update my profile now",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabBarView() {
    return TabBarView(
      children: <Widget>[
        PatientDemographicsTab(
          patientData: widget.patientData,
          formKey: formKeys[0],
        ),
        AllergiesTab(
          allergies: widget.patientData.allergies ?? allerges,
          isEdited: (value) {
            log("allergyedited   $value");
            setState(() {
              isAllergyEdited = true;
            });
          },
        ),
        const VaccinationTab(),
        const PreviousReportTab(),
      ],
    );
  }

  PreferredSizeWidget customAppBar() {
    return AppBar(
      title: const Text(
        'Update Profile',
        style: TextStyle(fontSize: 20.0),
      ),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(248, 248, 248, 1),
            ),
            child: const TabBar(
                physics: BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.fast),
                padding: EdgeInsets.symmetric(horizontal: 20),
                isScrollable: true,
                labelColor: ColorKonstants.primarySwatch,
                unselectedLabelColor: Colors.black87,
                indicatorColor: ColorKonstants.primarySwatch,
                tabs: [
                  Tab(
                    child: Text(
                      'Demographics',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Tab(
                    child: Text('Allergies', style: TextStyle(fontSize: 16)),
                  ),
                  Tab(
                    child: Text('Vaccinations', style: TextStyle(fontSize: 16)),
                  ),
                  Tab(
                    child: Text('Previous Reports',
                        style: TextStyle(fontSize: 16)),
                  ),
                ]),
          )),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
              onPressed: () {
                // allergyRequestModel.other = "asasa";
                log(allerges.toString());
                updateAllergies();
                if (submitForm()) {
                  context
                      .read<UpdatePatientBloc>()
                      .add(UpdatePatientSubmittedEvent());
                  context.read<PatientBloc>().add(const PatientInitialEvent());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Please Enter required Fields'),
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          // Perform some action when the user presses the "Undo" button
                        },
                      ),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.check)),
        ),
      ],
    );
  }

  Future<bool>? updateAllergies() {
    // print('${isAllergyEdited}Here');
    if (isAllergyEdited) {
      log("patient allergies:${widget.patientData.allergies}");
      if (widget.patientData.allergies == null) {
        Allergiesrepository()
            .postAllergy(
                postAllergyRequest: PostAllergyRequest(
                    foodAllergies: allerges.foodAllergies,
                    medicineAllergies: allerges.medicineAllergies,
                    other: allerges.other,
                    patientId: allerges.patientId,
                    petAllergies: allerges.petAllergies))
            .then((value) {
          return true;
        });
      } else {
        widget.patientData.allergies?.foodAllergies
            .removeWhere((element) => element == "");
        widget.patientData.allergies?.medicineAllergies
            .removeWhere((element) => element == "");
        widget.patientData.allergies?.petAllergies
            .removeWhere((element) => element == "");
        Allergiesrepository()
            .updateAllergies(
          allergyId: widget.patientData.allergies?.id.toString() ?? '',
          patchAllergyRequest: PostAllergyRequest(
              foodAllergies: widget.patientData.allergies!.foodAllergies,
              medicineAllergies:
                  widget.patientData.allergies!.medicineAllergies,
              other: widget.patientData.allergies!.other,
              patientId: widget.patientData.allergies!.patientId,
              petAllergies: widget.patientData.allergies!.petAllergies),
        )
            .then((value) {
          return true;
        });
      }
    }
    return null;
  }
}
