import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:clinic_app/common_components/services/app_exceptions.dart';
import 'package:clinic_app/common_components/widgets/sharing_consent_dialog.dart';
import 'package:clinic_app/modules/Mediline/bloc/get_doctors_bloc.dart';
import 'package:clinic_app/modules/Mediline/models/revoke_appointment_request.dart';
import 'package:clinic_app/modules/Mediline/models/share_appointment_request.dart';
import 'package:clinic_app/modules/Mediline/models/share_appointment_response.dart';
import 'package:clinic_app/modules/Mediline/screens/share_appointment_screen.dart';
import 'package:clinic_app/modules/Mediline/screens/share_mediline_screen.dart';
import 'package:clinic_app/modules/Mediline/services/mediline_repository.dart';
import 'package:clinic_app/modules/Mediline/widgets/mediline_upcoming_appointment_popup_widget.dart';
import 'package:clinic_app/utils/SharePref.dart';
import 'package:clinic_app/utils/constants/terms_konstants.dart';
import 'package:clinic_app/utils/helper/helper.dart';

import '../../../common_components/widgets/popup_widget.dart';
import '../../../utils/constants/color_konstants.dart';
import '../../../utils/constants/image_konstants.dart';
import '../bloc/mediline_bloc.dart';
import '../models/get_appointmens_response.dart';

class MedilineCard extends StatefulWidget {
  final AppointmentDatum appointmentDetail;
  final bool isUpcoming;
  MedilineCard({
    super.key,
    required this.appointmentDetail,
    this.isUpcoming = false,
  });

  @override
  State<MedilineCard> createState() => _MedilineCardState();
}

class _MedilineCardState extends State<MedilineCard> {
  late Appointment appointment;
  bool isUpcoming = false;
  @override
  void initState() {
    isUpcoming = widget.appointmentDetail.appointment.appointmentDate
            .compareTo(DateTime.now()) >=
        0;
    log(widget.appointmentDetail.appointment.appointmentDate
        .compareTo(DateTime.now())
        .toString());
    appointment = widget.appointmentDetail.appointment;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.14;
    print(
        "Appointment detail: ${widget.appointmentDetail.appointment.appointmentDate}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: GestureDetector(
        onTap: () {
          if (widget.isUpcoming) {
            showPopup(
                context: context,
                child: MedilineUpcomingAppointmentPopupWidget(
                  appointmentDetail: widget.appointmentDetail,
                  onCancelAppointmentSuccess: () {
                    if (!mounted) return;
                    context
                        .read<MedilineBloc>()
                        .add(const MedilineGetAllAppointmetns());
                  },
                ));
          } else {
            showAppointmentCardBottomSheet(
                context: context, appointmentDetail: widget.appointmentDetail);
          }

          // if (isUpcoming) {
          //   showPopup(context: context, child: const MedilineCardDetailPopup());
          // } else {}
        },
        // height: height,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      width: 2,
                      height: height + 18,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Positioned(
                    top: (height + 18) / 2 - 4,
                    left: 1,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(
                          100,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 4,
              ),
              ClipPath(
                clipper: MyCustomClipper(),
                child: CustomPaint(
                  painter: BorderPainter(context: context),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.88,
                    height: MediaQuery.of(context).size.height * 0.14,
                    color: Colors.grey.withOpacity(0.05),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        date(),
                        const VerticalDivider(
                          indent: 0,
                          endIndent: 0,
                          thickness: 1,
                        ),
                        detail(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget date() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            DateFormat('MMM').format(appointment.appointmentDate).toUpperCase(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            DateFormat('dd').format(appointment.appointmentDate).toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Text(
            DateFormat('yyyy')
                .format(appointment.appointmentDate)
                .toUpperCase(),
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: ColorKonstants.subHeadingTextColor),
          ),
        ],
      ),
    );
  }

  Widget detail() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Text(
                  widget.appointmentDetail.appointment.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Text(
                  appointment.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: const [
              ImageIconBox(image: ImagesConstants.docPlaceholder),
              ImageIconBox(image: ImagesConstants.clinicPlaceholder),
              ImageIconBox(image: ImagesConstants.docPlaceholder),
              ImageIconBox(image: ImagesConstants.docPlaceholder),
            ],
          )
        ],
      ),
    );
  }
}

class ImageIconBox extends StatelessWidget {
  const ImageIconBox({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill)),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double gap = 12;
    double borderRadius = 8;
    Path path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(gap, (size.height / 2) + gap)
      ..lineTo(gap, size.height - borderRadius)
      ..arcToPoint(Offset(gap + borderRadius, size.height),
          radius: Radius.circular(borderRadius), clockwise: false)
      ..lineTo(size.width - borderRadius, size.height)
      ..arcToPoint(Offset(size.width, size.height - borderRadius),
          radius: Radius.circular(borderRadius), clockwise: false)
      ..lineTo(size.width, borderRadius)
      ..arcToPoint(Offset(size.width - borderRadius, 0),
          radius: Radius.circular(borderRadius), clockwise: false)
      ..lineTo(gap + borderRadius, 0)
      ..arcToPoint(Offset(gap, borderRadius),
          radius: Radius.circular(borderRadius), clockwise: false)
      ..lineTo(gap, (size.height / 2) - gap)
      ..lineTo(0, size.height / 2) // Add line p2p3
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BorderPainter extends CustomPainter {
  BuildContext context;
  BorderPainter({required this.context});

  double gap = 12;
  @override
  void paint(Canvas canvas, Size size) {
    double borderRaius = 8;
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Theme.of(context).primaryColor.withOpacity(0.5);
    Path path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(gap, (size.height / 2) + gap)
      ..lineTo(gap, size.height - borderRaius)
      ..arcToPoint(Offset(gap + borderRaius, size.height),
          radius: Radius.circular(borderRaius), clockwise: false)
      ..lineTo(size.width - borderRaius, size.height)
      ..arcToPoint(Offset(size.width, size.height - borderRaius),
          radius: Radius.circular(borderRaius), clockwise: false)
      ..lineTo(size.width, borderRaius)
      ..arcToPoint(Offset(size.width - borderRaius, 0),
          radius: Radius.circular(borderRaius), clockwise: false)
      ..lineTo(gap + borderRaius, 0)
      ..arcToPoint(Offset(gap, borderRaius),
          radius: Radius.circular(borderRaius), clockwise: false)
      ..lineTo(gap, (size.height / 2) - gap)
      ..lineTo(0, size.height / 2)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

void showAppointmentCardBottomSheet(
    {required BuildContext context,
    required AppointmentDatum appointmentDetail,String? resp
    }) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
          height: 150.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SheetIconButton(
                      icon: Icons.label_important_outline_sharp,
                      text: "View Prescription Details",
                      onPressed: () => WidgetHelper.showToast("Coming Soon")),
                  SheetIconButton(
                      icon: Icons.video_call,
                      text: "Access Events Reports",
                       onPressed: () => WidgetHelper.showToast("Coming Soon")),
                  SheetIconButton(
                    icon: Icons.share,
                    text: "Share Event With",
                    onPressed: () {
                      SharingConsentDialog.showWarningDialog(
                        context,
                        TermsConstants.shareAppointmentConsent,
                        () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          showPopup(
                            context: context,
                              child: BlocProvider<GetAllDoctorsBloc>(
                              create: (context) => GetAllDoctorsBloc(),
                            child: ShareMedilinePopup(
                              shareFunction: ({required String doctorId}) async {
                                bool res = false;
                                await MedilineRepository()
                                    .shareAppointment(
                                    shareAppointmentRequest:
                                  ShareAppointmentRequest(
                                        sharedById: sharedPrefs.id!,
                                        sharedToId: doctorId,
                                        appointmentId: appointmentDetail.appointment.id,
                                  )).then((value) {
                                  res = true;
                                  resp=value.data?.sharedAppointmentId??"";
                                }).catchError((e) {
                                  String msgStr = e.toString();
                                  if (e is BadRequestException) {
                                    res = true;
                                    msgStr = 'Appointment Already shared';
                                  }
                                  WidgetHelper.showToast(msgStr);
                                  log(msgStr);
                                });
                                return res;
                              },
                              revokeFunction: (
                                  {required String doctorId}) async {
                                bool res = true;
                                await MedilineRepository()
                                    .revokeAppointmentToDoctor(
                                    appointmentId:resp??"",

                                )
                                    .then((value) {
                                  res = false;
                                }).catchError((error) {
                                  WidgetHelper.showToast(error.toString());
                                });
                                return res;
                              },
                              appointmentDetailList: [appointmentDetail],
                            ),
                          ));
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ));
    },
  );
}

class SheetIconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onPressed;
  final bool isDelete;
  const SheetIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.text,
    this.isDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.29,
        height: 100,
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor:
                  isDelete ? Colors.red : ColorKonstants.primaryColor,
              radius: 20,
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
