import 'package:flutter/material.dart';
import 'package:clinic_app/modules/Mediline/models/get_appointmens_response.dart';
import 'package:clinic_app/modules/NewAppointment/screens/payment_screen.dart';
import 'package:clinic_app/modules/search/models/doctor_response.dart';
import 'package:clinic_app/utils/constants/color_konstants.dart';

class DoctorCard extends StatefulWidget {
  final GetDoctorsData doctor;
  //final String reportId;
  final Function shareFunction;
  final Function revokeFunction;
  final List<AppointmentDatum> appointmentDetailList;
  const DoctorCard({
    super.key,
    required this.doctor,
    //required this.reportId,
    required this.shareFunction,
    required this.revokeFunction, required this.appointmentDetailList,
  });

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  bool isShared = false;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
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
                      padding: const EdgeInsets.only(top: 12),
                      child: appointmentDetail()),
                ],
              ),
              shareButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget clinicDetail() {
    return Column(
      children: [
        Row(
          children: [
            ProfileImage(image: widget.doctor.user.photo ?? "", scale: 0.2),
            Column(
              children: [
                Text(widget.doctor.user.name),
                Text("Doctor ID ${widget.doctor.user.id}"),
                Text(widget.doctor.user.address),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget appointmentDetail() {
    return ClipPath(
      clipper: MyCustomClipperBottom(radius: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ProfileImage(
                      scale: 0.2, image: widget.doctor.user.photo ?? ""),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.doctor.user.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Doctor ID ${widget.doctor.doctor.id}",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.doctor.user.address,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
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

  Widget shareButton() {
    return ClipPath(
      clipper: MyCustomClipperTop(radius: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            // const SizedBox(
            //   height: 8,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: isShared
                                ? Colors.red
                                : ColorKonstants.primaryColor),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          bool res = isShared
                              ? await widget.revokeFunction()
                              : await widget.shareFunction();
                          setState(() {
                            isShared = res;
                            loading = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: loading
                              ? const CircularProgressIndicator()
                              : isShared
                                  ? const Text("Revoke Sharing")
                                  : const Text("Share with this Doctor"),
                        ))),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
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
