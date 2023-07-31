import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:clinic_app/common_components/widgets/popup_widget.dart';
import 'package:clinic_app/modules/MyJatya/models/upcoming_appointment_model.dart';
import 'package:clinic_app/modules/MyJatya/widgets/upcoming_appointment_recipt.dart';
import 'package:clinic_app/modules/MyPrescription/bloc/get_prescription_bloc_bloc.dart';
import 'package:clinic_app/modules/MyPrescription/models/latest_prescription.dart';
import 'package:clinic_app/modules/MyPrescription/screens/prescription_detail_tabview.dart';
import 'package:clinic_app/modules/Reports/screens/main_report_screen.dart';
import 'package:clinic_app/utils/SharePref.dart';
import 'package:clinic_app/utils/constants/color_konstants.dart';
import 'package:clinic_app/utils/helper/helper.dart';

import '../../../common_components/widgets/common_drawer.dart';
import '../../../utils/constants/image_konstants.dart';
import '../bloc/upcoming_apppointment/upcoming_appointmen_bloc.dart';

class MyJatya extends StatefulWidget {
  const MyJatya({super.key});

  @override
  State<MyJatya> createState() => _MyJatyaState();
}

class _MyJatyaState extends State<MyJatya> {
  GetAllAppointmentsResponse? _allAppointmentsResponse;
  GetAllPrecriptionResposnse? getAllPrecriptionResposnse;
  @override
  void initState() {
    BlocProvider.of<UpcomingAppointmenBloc>(context)
        .add(GetUpcomingApppointmentEvent());
    BlocProvider.of<GetPrescriptionBlocBloc>(context)
        .add(GetAllPrescriptionEvent());
    super.initState();
  }

  String currentDateString = DateFormat("dd MMMM yyyy").format(DateTime.now());
  String latestPresDate = DateFormat("dd MMMM yyyy").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    // var devicesize = MediaQuery.of(context).size;
    return BlocListener<UpcomingAppointmenBloc, UpcomingAppointmenState>(
      listener: (context, state) {
        // print("state is $state");
        // if (state is UpcomingAppointmenloading) {
        //   showDialog(
        //       context: context,
        //       builder: (context) =>
        //           const Center(child: CircularProgressIndicator()));
        //   log("loading in getting upcoming appointment details");
        // }
        if (state is UpcomingAppointmeFailure) {
          // Navigator.pop(context);
          WidgetHelper.showToast(state.err);
        }
        if (state is UpcomingAppointmenSuccess) {
          // Navigator.pop(context);
          // Navigator.pop(context);
          DateTime upcomingDate =
              nearestIndexFinder(state.getAllAppointments.data)
                  .appointment
                  .appointmentDate;
          setState(() {
            currentDateString = DateFormat("dd MMMM yyyy").format(upcomingDate);
            _allAppointmentsResponse = state.getAllAppointments;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("My Jatya"),
          centerTitle: false,
        ),
        drawer: const CommonDrawer(),
        body: Container(
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              // ElevatedButton(
              //   onPressed: () async {
              //     final data = await getRefreshToken('11');
              //
              //     if (data != null) {
              //       WidgetHelper.showToast('Syncing successful');
              //     } else {
              //       WidgetHelper.showToast(
              //           'Something went wrong, try again...');
              //     }
              //   },
              //   child: Text('Check'),
              // ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "WELCOME BACK, ${sharedPrefs.name?.toUpperCase()}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: ColorKonstants.labelTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (_allAppointmentsResponse == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("No upcoming appointments!")));
                    return;
                  }
                  showPopup(
                    context: context,
                    child: UpcomingAppointmentRecipt(
                      getAllAppointment: _allAppointmentsResponse!,
                    ),
                    // onCancelAppointmentSuccess: () {
                    // if (!mounted) return;
                    // context
                    //     .read<MedilineBloc>()
                    //     .add(const MedilineGetAllAppointmetns());
                 // },
                  );
                },
                child: jatyaItems(ImagesConstants.appointmentDrawer,
                    "UPCOMING APPOINTMENT", "On $currentDateString", () {}),
              ),
              const SizedBox(
                height: 15,
              ),
              BlocListener<GetPrescriptionBlocBloc, GetPrescriptionBlocState>(
                listener: (context, state) {
                  // if (state is GetPrescriptionBlocloading) {
                  //   showDialog(
                  //       context: context,
                  //       builder: (context) =>
                  //           const Center(child: CircularProgressIndicator()));

                  //   log("loading in getting prescription");
                  // }
                  if (state is GetPrescriptionBlocFailure) {
                    // Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("There is no prescription available")));
                  }
                  if (state is GetPrescriptionBlocSuccess) {
                    // Navigator.pop(context);
                    GetAllPrescriptionData? latestPrescription =
                        fetchLatestPrescription(state.getAllPrescriptions.data);
                    setState(() {
                      getAllPrecriptionResposnse = state.getAllPrescriptions;
                      if (latestPrescription != null) {
                        latestPresDate = DateFormat('dd MMMM yyyy').format(
                            DateTime.parse(latestPrescription.createdDate ??
                                latestPresDate));
                      }
                    });
                  }
                },
                child: GestureDetector(
                  onTap: () {
                    if (getAllPrecriptionResposnse == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("There is no prescription available")));
                    } else if (getAllPrecriptionResposnse!.data != null) {
                      if (getAllPrecriptionResposnse!.data!.isNotEmpty) {
                        GetAllPrescriptionData? getAllPrescriptionData =
                            getAllPrecriptionResposnse!.data!.first;
                        getAllPrescriptionData.createdDate =
                            findNearestDate(getAllPrecriptionResposnse!.data);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PrescriptionDetailTabview(
                              getAllPrescriptionData: getAllPrescriptionData);
                        }));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "There is no prescription available")));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("There is no prescription available")));
                    }
                  },
                  child: jatyaItems(ImagesConstants.prescriptionDrawer,
                      "LATEST PRESCRIPTION", 'On $latestPresDate', () {}),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainReportsScreen(),
                    ),
                  );
                },
                child: jatyaItems(
                    ImagesConstants.reportDrawer,
                    "RECENT REPORTS",
                    "Blood test- Sugar level, Creatinine...", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainReportsScreen(),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget jatyaItems(
      String myImage, String title, String subtitle, VoidCallback clicked) {
    return Container(
      width: 366,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorKonstants.tileBackGround,
          border: Border.all(color: Colors.black, width: 0.2)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon(
            //   Icons.calendar_month,
            //   color: Colors.black,
            //   size: 25,
            // ),

            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  SvgPicture.asset(
                    myImage,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.srcATop),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: ColorKonstants.textcolor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.black54),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 2,
            // ),
            const Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(right: 10, left: 20),
                child: SizedBox(
                    height: 30,
                    width: 30,
                    child: InkWell(
                        hoverColor: ColorKonstants.textcolor,
                        focusColor: ColorKonstants.textcolor,
                        highlightColor: ColorKonstants.textcolor,
                        // Image tapped
                        splashColor: Colors.white, // Splash color over image
                        child: Image(
                            color: ColorKonstants.primarySwatch,
                            image: AssetImage(
                                ImagesConstants.rightArrowOutlined)))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String findNearestDate(List<GetAllPrescriptionData>? data) {
    DateTime now = DateTime.now();
    DateTime nearestDate = DateTime.parse(data!.first.createdDate!);

    for (var prescription in data) {
      log(prescription.createdDate.toString());
      DateTime? currentDate = prescription.createdDate != null
          ? DateTime.parse(prescription.createdDate!)
          : null;

      if (currentDate != null) {
        Duration diff1 = now.difference(currentDate).abs();
        Duration diff2 = now.difference(nearestDate).abs();

        if (diff1 < diff2) {
          nearestDate = currentDate;
          log(nearestDate.toString());
        }
      }
    }
    GetAllPrescriptionData nearestPrescription = data.firstWhere(
      (prescription) =>
          DateTime.parse(prescription.createdDate!) == nearestDate,
    );

    return nearestDate.toString();
  }

  GetAllPrescriptionData? fetchLatestPrescription(
      List<GetAllPrescriptionData>? data) {
    if (data == null || data.isEmpty) {
      return null; // Return null if the list is empty
    }

    // Sort the list in descending order based on createdDate
    data.sort((a, b) => b.createdDate!.compareTo(a.createdDate!));

    // Return the first element which will be the latest prescription
    return data.first;
  }
}
