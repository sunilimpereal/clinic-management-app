import 'package:flutter/material.dart';
import 'package:clinic_app/common_components/widgets/app_alert_dialog.dart';
import 'package:clinic_app/common_components/widgets/link_text.dart';
import 'package:clinic_app/utils/constants/color_konstants.dart';

class SharingConsentDialog {
  static void showWarningDialog(
      BuildContext context, String text, void Function() onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 170,left: 20),
          child: AppAlertDialog(
            iconColor: Colors.orangeAccent,
            icon: const Icon(
              Icons.warning,
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height > 667
                ? MediaQuery.of(context).size.height * 0.45
                : MediaQuery.of(context).size.height * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: ColorKonstants.primaryColor,
                    ),
                    onPressed: onPressed,
                    child: const Text(
                      "OK, Proceed",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                LinkText(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Cancel",
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
