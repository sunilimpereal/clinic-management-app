import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clinic_app/common_components/model/errors/clinic_working_hours_model.dart';
import 'package:clinic_app/common_components/widgets/clinic_working_hours_widget.dart';
import 'package:clinic_app/modules/MyPrescription/models/prescription_deatils/prescription_details.dart';
import 'package:clinic_app/utils/constants/color_konstants.dart';
import 'package:clinic_app/utils/constants/image_konstants.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../common_components/widgets/common_drawer.dart';
import '../../../../utils/helper/map_utils.dart';

class AbouttheClinicScreen extends StatelessWidget {
  final ClinicDetails? clinicInformation;
  const AbouttheClinicScreen({super.key, required this.clinicInformation});

  @override
  Widget build(BuildContext context) {
    ClinicWorkingHour? workingHourList = clinicInformation?.clinicWorkingHours;
    var devicesize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const CommonDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  clinicDetails(
                      clinicInformation?.name ?? "A1 Dental Clinic",
                      clinicInformation?.subscriptionId.toString() ?? "JTY003",
                      "ORTHODONTICS …",
                      clinicInformation?.logo

                      // clinicInformation?.speciality?.first ?? "ORTHODONTICS …",
                      ),
                  const Divider(
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 25, // set the radius of the circle
                        backgroundImage:
                            AssetImage(ImagesConstants.ladyDocImage),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 17),
                                child: Text(
                                  clinicInformation?.socialMediaHandle ??
                                      "Shilpa Sanam",
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "BDS, MDS (Public Health...",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Container(
                                width: 120,
                                height: 22,
                                padding: EdgeInsets.only(
                                    left: devicesize.width * 0.04),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: ColorKonstants.clinicOnwerTag,
                                ),
                                child: const Center(
                                  child: Text(
                                    "CLINIC OWNER",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  if(workingHourList != null)
                    ClinicWorkingHourWidget(workingHours: workingHourList!),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 0),
                  //   child: Column(
                  //     children: [consultingHours(workingHourList)],
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                      launchUrlString('tel:${clinicInformation?.mobileNumbers?.first ??
                          '+91 1234567890'}');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorKonstants.primarySwatch),
                  child: const Text("Call Clinic"),
                )),
            TextButton(
                onPressed: () => launchUrlString('mailto:${clinicInformation?.emailId ?? 'alex@example.com'}'),
                /*ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('This feature is coming soon!'),
                        duration: Duration(seconds: 3),
                      ),
                    ),*/
                child: const Text(
                  "Send Email",
                  style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline),
                ))
          ],
        ),
      ),
    );
  }

  Widget clinicDetails(String clinicName, String jatyaClinicId, String type,String? logo) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
               CircleAvatar(
                radius: 27,
                backgroundImage: NetworkImage(logo ?? ImagesConstants.ladyDocImage),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clinicName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        jatyaClinicId,
                        style: TextStyle(
                          fontSize: 14.8,
                          fontWeight: FontWeight.w400,
                          color: ColorKonstants.headingTextColor,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Center(
                        child: Text('\u2022',
                            style: TextStyle(fontSize: 24, color: Colors.grey)),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        type,
                        style: TextStyle(
                          fontSize: 14.8,
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
            padding: const EdgeInsets.only(left: 64, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap:(){
                    launchUrlString('tel:${clinicInformation?.mobileNumbers?.first ??
                        '+91 1234567890'}');
                  },
                  child: infoItems(
                      CupertinoIcons.phone,
                      clinicInformation?.mobileNumbers?.first ??
                          '+91 1234567890'),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: (){
                    launchUrlString('mailto:${clinicInformation?.emailId ?? 'alex@example.com'}');
                  },
                  child: infoItems(CupertinoIcons.mail,
                      clinicInformation?.emailId ?? 'alex@example.com'),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    MapUtils.openMap(clinicInformation?.address ??
                        '123, ABC Street, XYZ City - 123456');
                  },
                  child: infoItems(
                      CupertinoIcons.location_solid,
                      clinicInformation?.address ??
                          '123, ABC Street, XYZ City - 123456'),
                ),
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
                decoration: TextDecoration.underline,
                height: 1.5,
              )),
        ),
      ],
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
                color:  ColorKonstants.subHeadingTextColor.withOpacity(0.6),
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
                color:  ColorKonstants.subHeadingTextColor.withOpacity(0.6),
                height: 1.5,
              ),
            ),
          )
        ],
      ),
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
}
