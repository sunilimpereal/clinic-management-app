import 'package:flutter/material.dart';
import 'package:clinic_app/common_components/widgets/app_alert_dialog.dart';
import 'package:clinic_app/common_components/widgets/link_text.dart';
import 'package:clinic_app/common_components/widgets/popup_widget.dart';
import 'package:clinic_app/modules/Auth/screens/login_screen.dart';
import 'package:clinic_app/modules/Profile/services/patient_repositroy.dart';
import 'package:clinic_app/utils/SharePref.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../utils/constants/color_konstants.dart';
import '../../../../utils/constants/image_konstants.dart';
import '../../screens/patient_profile_screen.dart';
import '../callus_popup_dialog.dart';
import 'package:clinic_app/utils/helper/helper.dart';

class DeleteProfile extends StatelessWidget {
  const DeleteProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Need Help?"),
              const SizedBox(
                width: 2,
              ),
              GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Center(
                        child: ProfilePopupDialog(
                          height: 275,
                          side: true,
                          backColor: Colors.grey.shade100,
                          image: ImagesConstants.jatyalogoCircular,
                          child: callUs(context),
                        ),
                      ),
                    );
                  },
                  child: customTextFieldBlack("Call us", isUnderline: true)),
            ],
          ),
          LinkText(
              onPressed: () {
                showPopup(context: context, child: const DeletePopup());
              },
              text: "Delete Account"),
          LinkText(
              onPressed: () {
                showPopup(context: context, child: const DeleteDataPopup());
              },
              text: "Delete Personal Data"),
        ],
      ),
    );
  }

  Widget callUs(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Jatya Support Center",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "+919373363414",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: ColorKonstants.textgrey,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                launchUrlString("tel://+919373363414");
              },
              child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          width: 1.5, color: ColorKonstants.blueccolor)),
                  child: const Icon(
                    Icons.phone,
                    size: 16,
                  )),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Jatya Support Center",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "+919373363414",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: ColorKonstants.textgrey,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                launchUrlString("tel://+919373363414");
              },
              child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          width: 1.5, color: ColorKonstants.blueccolor)),
                  child: const Icon(
                    Icons.phone,
                    size: 16,
                  )),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Jatya Support Center",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "support@jatyatech.com",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: ColorKonstants.textgrey,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                launchUrlString("mailto:support@jatyatech.com");
              },
              child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          width: 1.5, color: ColorKonstants.blueccolor)),
                  child: const Icon(
                    Icons.mail_outline_rounded,
                    size: 16,
                  )),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Close",
            style: TextStyle(
                decoration: TextDecoration.underline, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class DeleteDataPopup extends StatelessWidget {
  const DeleteDataPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAlertDialog(
        iconColor: Colors.red.shade700,
        icon: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          children: [
            const Text(
              "Delete Personal Data",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Are you sure you want to delete your personal data?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.grey)),
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      backgroundColor: Colors.red.shade700,
                    ),
                    onPressed: () async {
                      final response =
                          await PatientRepository().deletePersonalDataPatient();
                      if (response == null) {
                        WidgetHelper.showToast(
                            'Something went wrong, try again...');
                        return;
                      }
                      if (response.success) {
                        Future.delayed(
                          const Duration(milliseconds: 100),
                          () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) =>
                                  false, // Remove all existing routes from the stack
                            );
                            sharedPrefs.setLogout();
                          },
                        );
                      }
                    },
                    child: const Text("Delete"))
              ],
            )
          ],
        ));
  }
}

class DeletePopup extends StatelessWidget {
  const DeletePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAlertDialog(
        iconColor: Colors.red.shade700,
        icon: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          children: [
            const Text(
              "Delete Account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Are you sure you want to delete your account",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.grey)),
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      backgroundColor: Colors.red.shade700,
                    ),
                    onPressed: () async {
                      final response =
                          await PatientRepository().deletePatient();
                      if (response.status == 200) {
                        Future.delayed(
                          const Duration(milliseconds: 100),
                          () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) =>
                                  false, // Remove all existing routes from the stack
                            );
                            sharedPrefs.setLogout();
                          },
                        );
                      }
                    },
                    child: const Text("Delete"))
              ],
            )
          ],
        ));
  }
}
