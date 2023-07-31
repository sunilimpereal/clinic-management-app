import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clinic_app/modules/MyPrescription/models/prescription_deatils/prescription_details.dart';
import 'package:clinic_app/utils/constants/image_konstants.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../common_components/widgets/common_drawer.dart';
import '../../../../utils/constants/color_konstants.dart';
import '../../../../utils/helper/helper.dart';
import '../../../../utils/helper/map_utils.dart';

class DoctorsProfile extends StatelessWidget {
  final DoctorDetails? doctorDetails;
  final bool isFromNotification;
  const DoctorsProfile(
      {super.key,
      required this.doctorDetails,
      this.isFromNotification = false});

  @override
  Widget build(BuildContext context) {
    var devicesize = MediaQuery.of(context).size;
    //log("Doctor details: ${doctorDetails?.doctor?}");
    return Scaffold(
      appBar: isFromNotification
          ? AppBar(
              title: const Text("Doctor's profile"),
            )
          : null,
      backgroundColor: Colors.white,
      drawer: isFromNotification ? null : const CommonDrawer(),
      body: doctorDetails == null
          ? const Center(
              child: Text("Something went wrong"),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(devicesize.width * 0.03),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                    radius: 25, // set the radius of the circle
                                    backgroundImage: NetworkImage(doctorDetails
                                            ?.userData?.photo ?? ImagesConstants.networkImageProfilePicPlacholder)),
                              ),
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            doctorDetails?.userData?.name ??
                                                "Dr. Neetu Sharma",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            width: 85,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: const Color.fromARGB(
                                                    220, 179, 218, 255)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: const [
                                                Icon(
                                                  Icons.check,
                                                  color: Colors.blue,
                                                  size: 18,
                                                ),
                                                Text(
                                                  "VERIFIED",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 12.5,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (doctorDetails?.doctor
                                                      ?.specialisation !=
                                                  null ||
                                              doctorDetails?.specialisation !=
                                                  null)
                                            Text(
                                              doctorDetails
                                                      ?.doctor
                                                      ?.specialisation
                                                      ?.specialisation ??
                                                  "MBBS, MD in Dermat.",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: ColorKonstants
                                                    .labelTextColor,
                                              ),
                                            ),
                                          Container(
                                            width: 75,
                                            height: 22,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Colors.black,
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "DOCTOR",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 39,
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 15),
                            child: textHeading("PERSONAL INFORMATION"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 52, top: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () => launchUrlString(
                                      'tel:${doctorDetails?.userData?.phoneNumber ?? '+91 1234567890'}'),
                                  child: infoItems(
                                      CupertinoIcons.phone,
                                      doctorDetails?.userData?.phoneNumber ??
                                          '+91 1234567890'),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: () => launchUrlString(
                                      'mailto:${doctorDetails?.userData?.email ?? 'alex@example.com'}'),
                                  child: infoItems(
                                      CupertinoIcons.mail,
                                      doctorDetails?.userData?.email ??
                                          'alex@example.com'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () => MapUtils.openMap(
                                      doctorDetails?.userData?.address ??
                                          '123, ABC Street, XYZ City - 123456'),
                                  child: infoItems(
                                      CupertinoIcons.location_solid,
                                      doctorDetails?.userData?.address ??
                                          '123, ABC Street, XYZ City - 123456'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Divider(color: Colors.black),
                          consultingHours(doctorDetails?.workingHours ?? []),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          WidgetHelper.showToast('Coming Soon!!');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorKonstants.primarySwatch),
                        child: const Text("Consult Doctor Online"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () =>
                            WidgetHelper.showToast('Coming Soon!!'),
                        /*ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('This feature is coming soon!'),
                                duration: Duration(seconds: 3),
                              ),*/
                        child: const Text(
                          "Send Message",
                          style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline),
                        ))
                  ],
                ),
              ),
            ),
    );
  }
}

Widget textHeading(String title) {
  return Align(
    alignment: Alignment.topLeft,
    child: Text(title,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: ColorKonstants.labelTextColor)),
  );
}

Widget customTextFieldBlack(String val, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Text(
      val,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.5,
      ),
    ),
  );
}

Widget clinicDetails(String clinicName, String jatyaClinicId, String type) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 25,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clinicName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      jatyaClinicId,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: ColorKonstants.headingTextColor,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: Text('\u2022',
                          style: TextStyle(fontSize: 26, color: Colors.grey)),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      type,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: ColorKonstants.headingTextColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 55, top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              infoItems(CupertinoIcons.phone, '+91 1234567890'),
              const SizedBox(
                height: 8,
              ),
              infoItems(CupertinoIcons.mail, 'alex@example.com'),
              const SizedBox(
                height: 10,
              ),
              infoItems(CupertinoIcons.location_solid,
                  '123, ABC Street, XYZ City - 123456'),
            ],
          ),
        ),
      ]);
}

Widget infoItems(IconData? icon, String title) {
  return Row(
    children: [
      Icon(
        icon,
        color: Colors.black54,
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Text(title,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorKonstants.headingTextColor,
                height: 1.5,
                decoration: TextDecoration.underline)),
      ),
    ],
  );
}

Widget consultingHours(List<WorkingHours> doctorWorkingHours) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 80),
            child: textHeading("CONSULTING HOURS")),
        Column(
            children: doctorWorkingHours
                .map((e) => timingTile(
                    day: e.weekday ?? "",
                    time:
                        "${DateFormat('hh:mm a').format(e.startTime!)} - ${DateFormat('hh:mm a').format(e.endTime!)}"))
                .toList()),
      ],
    ),
  );
}

Widget timingTile({
  required String day,
  required String time,
}) {
  return Container(
    padding: const EdgeInsets.all(5),
    width: 260,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            day,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ColorKonstants.subHeadingTextColor.withOpacity(0.6),
              height: 1.5,
            ),
          ),
        ),
        SizedBox(
          width: 140,
          child: Text(
            time,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorKonstants.subHeadingTextColor.withOpacity(0.6),
              height: 1.5,
            ),
          ),
        )
      ],
    ),
  );
}
