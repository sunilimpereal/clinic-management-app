import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jatya_patient_mobile/common_components/widgets/label.dart';
import 'package:jatya_patient_mobile/common_components/widgets/map_icon.dart';
import 'package:jatya_patient_mobile/common_components/widgets/qr_code_placeholder.dart';
import 'package:jatya_patient_mobile/common_components/widgets/sync_tile.dart';
import 'package:jatya_patient_mobile/modules/Mediline/screens/my_mediline_screen.dart';
import 'package:jatya_patient_mobile/modules/MyJatya/bloc/upcoming_apppointment/upcoming_appointmen_bloc.dart';
import 'package:jatya_patient_mobile/modules/MyJatya/models/upcoming_appointment_model.dart';
import 'package:jatya_patient_mobile/modules/MyJatya/screens/MyJatya.dart';
import 'package:jatya_patient_mobile/modules/MyJatya/widgets/watch_data_preview.dart';
import 'package:jatya_patient_mobile/modules/NewAppointment/screens/payment_screen.dart';
import 'package:jatya_patient_mobile/utils/constants/color_konstants.dart';

class UpcomingAppointmentRecipt extends StatefulWidget {
  final GetAllAppointmentsResponse getAllAppointment;

  const UpcomingAppointmentRecipt({
    Key? key,
    required this.getAllAppointment,
  }) : super(key: key);

  @override
  State<UpcomingAppointmentRecipt> createState() =>
      _UpcomingAppointmentReciptState();
}

class _UpcomingAppointmentReciptState extends State<UpcomingAppointmentRecipt> {
  final UpcomingAppointmenBloc _upcomingAppointmenBloc =
      UpcomingAppointmenBloc();

  late GetAllAppointmentsData nearestIndex;

  Map? graphData;

  @override
  void initState() {
    log("Initstate from upc_appoint_recipt.dart");
    _upcomingAppointmenBloc.add(GetUpcomingApppointmentEvent());
    super.initState();
  }

  @override
  void dispose() {
    _upcomingAppointmenBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    nearestIndex = nearestIndexFinder(widget.getAllAppointment.data);

    return BlocListener<UpcomingAppointmenBloc, UpcomingAppointmenState>(
      bloc: _upcomingAppointmenBloc,
      listener: (context, state) {
        if (state is CancelAppointAndNavigatePop) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyJatya(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Appointment Cancelled'),
              duration: Duration(seconds: 3),
            ),
          );
        }
        if (state is CancelAppointmentFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Appointment not Cancelled'),
              duration: Duration(seconds: 3),
            ),
          );
        }
        if (state is UpcomingAppointmeFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      child: body(context, widget.getAllAppointment, nearestIndex),
    );
  }

  Widget body(
      BuildContext context,
      GetAllAppointmentsResponse getAllAppointments,
      GetAllAppointmentsData nearestData) {
    GetAllAppointmentsDataModel? appointmentModel = nearestData.appointment;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadiusDirectional.circular(8),
        clipBehavior: Clip.hardEdge,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.hardEdge,
          width: MediaQuery.of(context).size.width * 0.90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                      padding: const EdgeInsets.only(top: 48),
                      child: appointmentDetail(nearestData)),
                ],
              ),
              clinicDetail(appointmentModel, nearestData.clinic),
            ],
          ),
        ),
      ),
    );
  }

  Widget appointmentDetail(GetAllAppointmentsData? appointmentsDetailsData) {
    String appointmentDate = "Tue, Dec 6 ";
    String appointmentStartTime = "6:30";
    String appointmentendTime = "7:30 AM";
    if (appointmentsDetailsData != null) {
      appointmentDate = getSplitedDateAndTimeString(
          appointmentsDetailsData.appointment.appointmentDate, true);
      appointmentStartTime = getSplitedDateAndTimeString(
          appointmentsDetailsData.appointment.startTime, false);
      appointmentendTime =
          "${getSplitedDateAndTimeString(appointmentsDetailsData.appointment.endTime, false)} ${DateFormat('a').format(appointmentsDetailsData.appointment.endTime)}";
    }

    return ClipPath(
      clipper: MyCustomClipperBottom(radius: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: ColorKonstants.greyBG,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: ProfileImage(
                      scale: 0.2,
                      image:
                          appointmentsDetailsData?.doctor.userData.photo ?? ""),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        appointmentsDetailsData?.appointment.title ??
                            "Dr. Aditi Sharma",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        appointmentsDetailsData?.appointment.speciality ??
                            "Urologist",
                        style: TextStyle(
                          color: ColorKonstants.headingTextColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Text(
                              appointmentDate,
                              style: TextStyle(
                                color: ColorKonstants.headingTextColor,
                              ),
                            ),
                            const Text('  |  '),
                            Text(
                              '$appointmentStartTime - $appointmentendTime',
                              style: TextStyle(
                                color: ColorKonstants.headingTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Stars(value: 5),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget clinicDetail(GetAllAppointmentsDataModel? appointmentsDetails,
      GetAllAppointmentsClinicData? clinic) {
    return ClipPath(
      clipper: MyCustomClipperTop(radius: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        height: (graphData == null)
            ? MediaQuery.of(context).size.height * 0.5
            : MediaQuery.of(context).size.height * 0.7,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              QRPlaceholder(context: context),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Label(
                            color: Colors.green,
                            label: Row(
                              children: const [
                                Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "PAID",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ],
                            ),
                            context: context,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "In-Person Consultation",
                            style: TextStyle(
                              color: ColorKonstants.headingTextColor,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Neurowell Clinic, Skydale, Bangalore",
                          style: TextStyle(
                            color: ColorKonstants.headingTextColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MapIcon(
                      geoLocation: clinic?.geoLocation,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              if (graphData == null)
                SyncTile(onData: (data) {
                  setState(() {
                    graphData = data;
                  });
                }),
              if (graphData != null)
                WatchDataPreviewUI(
                  data: graphData!,
                  isDialog: false,
                ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        width: 1.0,
                        color: Colors.red,
                      ),
                      backgroundColor: Colors.transparent),
                  onPressed: () {
                    _upcomingAppointmenBloc.add(CancelUpcomingAppointmentEvent(
                        appointmentId: appointmentsDetails?.id ?? ""));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Cancel Appointment",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyMedilineScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Back to my medi-line ",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black),
                  )),
              const SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showSummary(BuildContext context, Map data) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return WatchDataPreviewUI(data: data);
    },
  );
}

class MyCustomClipperBottom extends CustomClipper<Path> {
  double radius;
  MyCustomClipperBottom({required this.radius});
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, size.height - radius)
      ..arcToPoint(
        Offset(radius, size.height),
        radius: Radius.circular(radius.toDouble()),
      ) // Add line p1p2
      ..lineTo(size.width - radius, size.height)
      ..arcToPoint(Offset(size.width, size.height - radius),
          radius: Radius.circular(radius))
      ..lineTo(size.width, 0) // Add line p2p3
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MyCustomClipperTop extends CustomClipper<Path> {
  double radius;
  MyCustomClipperTop({required this.radius});
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(0, radius)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, radius)
      ..arcToPoint(Offset(size.width - radius, 0),
          radius: Radius.circular(radius))
      ..lineTo(radius, 0)
      ..arcToPoint(Offset(0, radius), radius: Radius.circular(radius))
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

String getSplitedDateAndTimeString(DateTime msg, bool isDate) {
  DateTime dateTime = msg;
  String time = "";

  if (isDate) {
    // Extract date using the DateFormat class
    time = DateFormat.yMd().format(dateTime);
  } else {
    // Extract hours and minutes using the DateFormat class
    time = DateFormat.Hm().format(dateTime);
  }

  return time;
}

GetAllAppointmentsData nearestIndexFinder(List<GetAllAppointmentsData> data) {
  DateTime now = DateTime.now();
  DateTime? nearestDateTime;
  int? nearestIndex;

  for (int i = 0; i < data.length; i++) {
    DateTime currentDateTime = data[i].appointment.appointmentDate;
    // Check if the current appointment's dateTime is in the future
    if (currentDateTime.isAfter(now)) {
      if (nearestDateTime == null ||
          currentDateTime.isBefore(nearestDateTime)) {
        nearestDateTime = currentDateTime;
        nearestIndex = i;
      }
    }
  }

  if (nearestDateTime == null) {
    return data[0];
  }

  return data[nearestIndex!];
}
