import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jatya_patient_mobile/common_components/widgets/label.dart';
import 'package:jatya_patient_mobile/common_components/widgets/map_icon.dart';
import 'package:jatya_patient_mobile/common_components/widgets/qr_code_placeholder.dart';
import 'package:jatya_patient_mobile/common_components/widgets/sync_tile.dart';
import 'package:jatya_patient_mobile/modules/NewAppointment/screens/payment_screen.dart';

import '../../../utils/constants/image_konstants.dart';
import '../../Mediline/screens/my_mediline_screen.dart';
import '../model/appointment/create_appointment_response.dart';
import '../model/doctors_via_location_response.dart';

class Recipt extends StatefulWidget {
  final AvailableDoctor availableDoctor;
  final CreateAppointmentResponse createAppointmentResponse;
  const Recipt({
    super.key,
    required this.availableDoctor,
    required this.createAppointmentResponse,
  });

  @override
  State<Recipt> createState() => _ReciptState();
}

class _ReciptState extends State<Recipt> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadiusDirectional.circular(80),
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
                      child: appointmentDetail()),
                  Positioned(
                    top: 28,
                    left: MediaQuery.of(context).size.width / 2.65,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.check_circle_rounded,
                        size: 48,
                        color: Colors.green,
                      ),
                    ),
                  )
                ],
              ),
              clinicDetail(),
            ],
          ),
        ),
      ),
    );
  }

  Widget appointmentDetail() {
    return ClipPath(
      clipper: MyCustomClipperBottom(radius: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ProfileImage(
                      scale: 0.2,
                      image: widget.availableDoctor.userData.photo ??
                          ImagesConstants.networkImageProfilePicPlacholder),
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
                        widget.availableDoctor.userData.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.availableDoctor.specialisation.specialisation,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${DateFormat("EEE").format(widget.createAppointmentResponse.startTime)}, ${DateFormat("MMM").format(widget.createAppointmentResponse.startTime)} ${widget.createAppointmentResponse.startTime.day} | ${DateFormat("hh:mm").format(widget.createAppointmentResponse.startTime)} -${DateFormat("hh:mm").format(widget.createAppointmentResponse.endTime)} ",
                        style: TextStyle(
                          color: Colors.grey.shade700,
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

  Widget clinicDetail() {
    return ClipPath(
      clipper: MyCustomClipperTop(radius: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            const SizedBox(height: 8),
            QRPlaceholder(context: context),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0, bottom: 6.0),
                      child: Text(widget.availableDoctor.doctorClinic.name),
                    ),
                    Row(
                      children: [
                        Label(
                          color: Colors.green,
                          label: Row(
                            children: [
                              const Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                widget.createAppointmentResponse.paymentStatus,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          context: context,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text("In-Person Consultation"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Address: ${widget.availableDoctor.userData.address}"),
                    )
                  ],
                ),
                const SizedBox(width: 8),
                MapIcon(
                  geoLocation: widget.availableDoctor.doctorClinic.geoLocation,
                )
              ],
            ),
            const SizedBox(height: 16),
            const SyncTile(),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyMedilineScreen(),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("OK, Show My Medi-line"),
                    ))),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
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
