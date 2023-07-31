import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:clinic_app/common_components/widgets/common_drawer.dart';
import 'package:clinic_app/modules/Profile/bloc/update_patient_bloc/updatepatient_bloc.dart';
import 'package:clinic_app/modules/Profile/models/patient/get_patient_details_response.dart';
import 'package:clinic_app/modules/Profile/models/patient/get_patinet_clinics_visited.dart';
import 'package:clinic_app/modules/Profile/screens/patient_change_password_screen.dart';
import 'package:clinic_app/modules/Profile/screens/patient_update_profile.dart';
import 'package:clinic_app/modules/Profile/widgets/patient_profile_header.dart';
import 'package:clinic_app/utils/SharePref.dart';
import 'package:clinic_app/utils/constants/image_konstants.dart';
import 'package:clinic_app/utils/helper/map_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../utils/constants/color_konstants.dart';
import '../bloc/patient_bloc/patient_bloc.dart';
import '../bloc/patient_change_password_bloc/patient_change_password_bloc.dart';
import '../bloc/previous_report_bloc/previousreport_bloc.dart';
import '../bloc/vaccinations_bloc/vaccinations_bloc.dart';
import '../screens/view_all_visited_clinic.dart';
import '../widgets/expandable_list_tile.dart';
import '../widgets/profile/delete_profile.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({Key? key}) : super(key: key);

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  @override
  void initState() {
    BlocProvider.of<PatientBloc>(context).add(const PatientInitialEvent());
    BlocProvider.of<VaccinationsBloc>(context)
        .add(const VaccinationsGetVaccineListEvent());
    BlocProvider.of<PreviousReportBloc>(context)
        .add(const PreviousReportInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
        ),
        drawer: const CommonDrawer(),
        body: BlocBuilder<PatientBloc, PatientState>(
          builder: (context, state) {
            if (state is PatientErrorState) {
              return Center(child: Text(state.error));
            }
            if (state is PatientLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PatientDetailsState) {
              PatientData patient = state.patientDetails;
              var dateString = DateFormat('dd/MM/yyyy')
                  .format(DateTime.parse(patient.userPatientData.lastLoggedIn));
              var hourString = DateFormat("hh:mm a")
                  .format(DateTime.parse(patient.userPatientData.lastLoggedIn));

              var passworddateString = DateFormat('dd/MM/yyyy').format(
                  DateTime.parse(patient.userPatientData.passwordLastUpdated));
              var passwordhourString = DateFormat("hh:mm a").format(
                  DateTime.parse(patient.userPatientData.passwordLastUpdated));
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PatientProfileHeader(
                        patientData: patient,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 4.0, top: 15),
                        child: Divider(thickness: 1),
                      ),
                      demographicsSection(context, patient),
                      const SizedBox(
                        height: 24,
                      ),
                      detailList(patient: patient),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Divider(thickness: 2),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textHeading("CLINIC I HAVE VISITED"),
                          state.allClinics.length > 3
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewAllVisitedClinic(
                                                    allClinics:
                                                        state.allClinics)));
                                  },
                                  child: textHeading("View All"))
                              : Container(),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ...state.allClinics.length > 3
                          ? state.allClinics.sublist(0, 3).map((e) {
                              return clinicDetails(e);
                            }).toList()
                          : state.allClinics.map((e) {
                              return clinicDetails(e);
                            }).toList(),

                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Divider(thickness: 2),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //for text Headings
                      textHeading(" APP DETAILS "),
                      const SizedBox(
                        height: 20,
                      ),
                      appDeatils(context, patient.patient.id, dateString,
                          hourString, passworddateString, passwordhourString),
                      const Divider(),
                      const DeleteProfile(),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ));
  }

  Widget textHeading(String title) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(title,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorKonstants.textgrey)),
    );
  }

  Widget demographicsSection(BuildContext context, PatientData patientData) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textHeading("PATIENT DEMOGRAPHICS"),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                textStyle: MaterialStateProperty.all(
                    const TextStyle(decoration: TextDecoration.underline)),
              ),
              child: GestureDetector(
                onTap: () {
                  context.read<UpdatePatientBloc>().add(
                      UpdatePatientInitialFillEvent(patientData: patientData));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PatientUpdateDetails(patientData: patientData),
                    ),
                  );
                },
                child: const Text('Edit Details',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorKonstants.textcolor)),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              patientDemographicItem(CupertinoIcons.phone,
                  patientData.userPatientData.phoneNumber ?? ''),
              patientDemographicItem(
                  CupertinoIcons.mail, sharedPrefs.emailId ?? "-"),
              patientDemographicItem(CupertinoIcons.location_solid,
                  '${patientData.userPatientData.addressLine1 ?? ''} ${patientData.userPatientData.addressLine2 ?? ''}'),
            ],
          ),
        )
      ],
    );
  }

  Widget patientDemographicItem(IconData? icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(title,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                height: 1.5,
              )),
        ),
      ],
    );
  }

  Widget detailList({required PatientData patient}) {
    Widget detailItem({required String title, required String data}) {
      return ListTile(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(data),
        ),
      );
    }

    return SizedBox(
      child: Column(
        children: [
          ExpandableListTile(
            expanded: [
              detailItem(
                title: "MEDICINE",
                data: patient.allergies?.medicineAllergies.join(",") ?? '',
              ),
              detailItem(
                title: "FOOD",
                data: patient.allergies?.foodAllergies.join(",") ?? '',
              ),
              detailItem(
                title: "PET",
                data: patient.allergies?.petAllergies.join(",") ?? '',
              )
            ],
            title: 'Allergies',
            viewAll: () {},
          ),
          BlocBuilder<VaccinationsBloc, VaccinationsState>(
            builder: (context, state) {
              return ExpandableListTile(
                expanded: state.vaccineList
                    .map(
                      (e) => ListTile(
                        title: Text(e?.vaccinationName ?? ''),
                      ),
                    )
                    .toList(),
                title: 'Vaccinations',
                viewAll: () {
                  context
                      .read<UpdatePatientBloc>()
                      .add(UpdatePatientInitialFillEvent(patientData: patient));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientUpdateDetails(
                        patientData: patient,
                        tab: 2,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          BlocBuilder<PreviousReportBloc, PreviousReportState>(
            builder: (context, state) {
              // List<ReportDatum> vaccineList = snapshot.data?.data ?? [];

              return state.reports.isEmpty
                  ? Container()
                  : ExpandableListTile(
                      expanded: state.reports
                          .map(
                            (e) => ListTile(
                              title: Text(e.reportName),
                            ),
                          )
                          .toList(),
                      title: 'Previous reports',
                      viewAll: () {
                        context.read<UpdatePatientBloc>().add(
                            UpdatePatientInitialFillEvent(
                                patientData: patient));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientUpdateDetails(
                              patientData: patient,
                              tab: 3,
                            ),
                          ),
                        );
                      },
                    );
            },
          )
        ],
      ),
    );
  }

  Widget expansionBox(IconData? icon, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: ColorKonstants.textcolor,
          ),
          Text(title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: ColorKonstants.textcolor)),
        ],
      ),
    );
  }

  Widget clinicDetails(PatientClinicsVisit clinic) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(clinic.logo),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clinic.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          clinic.id,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: ColorKonstants.headingTextColor,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Center(
                          child: Text('\u2022',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.grey)),
                        ),
                        const SizedBox(width: 5),
                        clinic.specialities.isEmpty
                            ? const Text("")
                            : Row(
                                children: [
                                  for (var item in clinic.specialities)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Text(
                                        item.speciality,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              ColorKonstants.headingTextColor,
                                          height: 1.2,
                                        ),
                                      ),
                                    ),
                                ],
                              )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.13),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  clinic.mobileNumbers.isEmpty
                      ? const Text("")
                      : Row(
                          children: [
                            for (var item in clinic.mobileNumbers)
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => launchUrlString('tel:$item'),
                                  child: patientDemographicItem(
                                      CupertinoIcons.phone, item),
                                ),
                              ),
                          ],
                        ),
                  GestureDetector(
                      onTap: () => launchUrlString('mailto:${clinic.emailId}'),
                      child: patientDemographicItem(
                          CupertinoIcons.mail, clinic.emailId)),
                  GestureDetector(
                    onTap: () =>
                        MapUtils.openMap("${clinic.address}-${clinic.zipCode}"),
                    child: patientDemographicItem(CupertinoIcons.location_solid,
                        "${clinic.address}-${clinic.zipCode}"),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  Widget appHeaderDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
                child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Image.asset(
                ImagesConstants.jatyalogoCircular,
                fit: BoxFit.cover,
              ),
            )),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Jatya App",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                customTextFieldgrey("Installed 3 days ago", fontSize: 16),
              ],
            ),
          ],
        ),
        Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(223, 177, 218, 255),
                border: Border.all(
                  color: const Color.fromARGB(223, 177, 218, 255),
                ),
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                    CupertinoIcons.tag_fill,
                    color: ColorKonstants.verifiedBorder,
                    size: 12,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const Padding(
                  padding: EdgeInsets.all(2.5),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "FREE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ColorKonstants.primarySwatch),
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }

  Widget appDeatils(BuildContext context, String userId, String logindate,
      String logintime, String passworddate, String passwordtime) {
    return Column(children: [
      appHeaderDetails(),
      Padding(
        padding: const EdgeInsets.only(left: 20, top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: customTextFieldBlack("Last Logged in"),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 7),
                    child: customTextFieldgrey(logindate)),
                customTextFieldgrey(logintime),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: customTextFieldBlack("Password Last\nUpdated"),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: customTextFieldgrey(passworddate),
                ),
                customTextFieldgrey(passwordtime),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 18, left: 18, right: 18, bottom: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlocProvider<PatientChangePassBloc>(
                          create: (context) => PatientChangePassBloc(),
                          child: PatientChangePasswordScreen(
                            userId: userId,
                          ),
                        ),
                      ));
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ColorKonstants.primaryColor,
                  ),
                  child: const Center(
                      child: Text(
                    'Change Password',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  )),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}

Widget customTextFieldBlack(String value, {bool isUnderline = false}) {
  return Text(
    value,
    style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
      color: Colors.black,
      height: 1.5,
    ),
  );
}

Widget customTextFieldgrey(String value, {double fontSize = 14}) {
  return Text(
    value,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
      height: 1.5,
    ),
  );
}
