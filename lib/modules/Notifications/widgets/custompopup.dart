import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic_app/modules/MyPrescription/models/prescription_deatils/prescription_details.dart';
import 'package:clinic_app/modules/Notifications/bloc/notification_bloc.dart';

import '../../../utils/constants/color_konstants.dart';
import 'package:clinic_app/modules/Notifications/models/notification_model.dart';
import '../../MyPrescription/screens/latest_prescription_tabs/doctors_profile.dart';
import '../models/doctorDetailNotification.dart';

class CustomPopupContent extends StatelessWidget {
  final NotificationModelData notificationData;
  final DoctorDetailsNotification? doctorDetails;
  final int page;
  final int unreadCount;
  final NotificationBloc dataBloc;
  // final String? doctorName;
  // final String? doctorImageUrl;
  // final String? doctorSpeciality;
  const CustomPopupContent({
    super.key,
    required this.notificationData,
    required this.page,
    required this.unreadCount,
    required this.dataBloc,
    // this.doctorImageUrl,
    // this.doctorName,
    // this.doctorSpeciality,
    this.doctorDetails,
  });

  @override
  Widget build(BuildContext context) {
    // get the screen dimensions
    //log("Doctor Details: ${doctorDetails!.userData}");
    log("Is Read: ${notificationData.read}");
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 36.0),
            child: Material(
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.hardEdge,
              color: Colors.white,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            notificationData.title ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (doctorDetails != null)
                          notificationHeader(context, doctorDetails!),
                        if (doctorDetails != null)
                          const SizedBox(
                            height: 20,
                          ),
                        Container(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.width * 0.2,
                            maxHeight: MediaQuery.of(context).size.width * 0.6,
                          ),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: SingleChildScrollView(
                            child: Text(
                              //"Lorem ipsum dolor sit ame, ut volutpatLorem ipsum dolor sit amet  augue gravida posuere. In a augue vel felis fringilla fringilla non ac ex. Nam vehicula neque a dolor cursus, dapibus fermentum justo sodales. Maecenas at malesuada eros, et mattis augue.",
                              notificationData.description ?? '',
                              style: const TextStyle(height: 1.5, fontSize: 14),
                            ),
                          ),
                        ),
                        if (doctorDetails != null)
                          const SizedBox(
                            height: 20,
                          ),
                        if (doctorDetails != null)
                          Center(
                            child: SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorKonstants.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () {
                                  log(doctorDetails!.doctor!.id!);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DoctorsProfile(
                                            isFromNotification: true,
                                            doctorDetails: DoctorDetails(
                                                doctor: doctorDetails?.doctor,
                                                userData:
                                                    doctorDetails?.userData,
                                                specialisation: doctorDetails!
                                                    .specialisation!,
                                                workingHours: doctorDetails
                                                    ?.workingHours),
                                          )));
                                },
                                child: const Text("View Doctor Profile"),
                              ),
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () async {
                                  if (notificationData.id != null &&
                                      notificationData.read != null) {
                                    dataBloc.add(
                                      MarkNotificationAsReadEvent(
                                        notificationData: notificationData,
                                        page: page,
                                        unreadCount: unreadCount,
                                      ),
                                    );
                                  }
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  notificationData.read == null
                                      ? "Mark as unread"
                                      : notificationData.read!
                                          ? "Mark as unread"
                                          : "Mark as read",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                  ),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Close",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: MediaQuery.of(context).size.width * 0.38,
            child: const CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: ColorKonstants.primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.notification_add_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget notificationHeader(
    BuildContext context, DoctorDetailsNotification doctorDetails) {
  return Row(
    children: [
      const SizedBox(
        width: 18,
      ),
      CircleAvatar(
        radius: 20, // set the radius of the circle
        backgroundImage: Image.network(doctorDetails.userData?.photo ??
                "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png")
            .image, // set the image path
        backgroundColor: Colors.blue,
      ),
      // CODE TO ADD CIRCULAR IMAGE LATER WHEN ASSET IS PROVIDED.
      const SizedBox(
        width: 10,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doctorDetails.userData?.name ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  doctorDetails.doctor?.specialisation?.specialisation ??
                      "MBBS, MD",
                  style: const TextStyle(
                      color: ColorKonstants.textgrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: const [
                      // Icon(
                      //   Icons.medication,
                      //   color: Colors.white,
                      //   size: 14,
                      // ), //TODO: stethoscope icon add when asset available
                      Text(
                        "Doctor",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// REMARKS:- ASSETS ARE MISSING AND IMAGE IS MISSING

