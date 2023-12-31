import 'package:flutter/material.dart';
import 'package:clinic_app/common_components/widgets/app_alert_dialog.dart';
import 'package:clinic_app/common_components/widgets/link_text.dart';
import 'package:clinic_app/modules/Auth/screens/login_screen.dart';

import '../../utils/SharePref.dart';

class LogoutAletDialog extends StatelessWidget {
  const LogoutAletDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAlertDialog(
      iconColor: Colors.red,
      icon: const Icon(
        Icons.logout,
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height > 667
          ? MediaQuery.of(context).size.height * 0.25
          : MediaQuery.of(context).size.height * 0.28,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Are you sure you want to log out?"),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(width: 1, color: Colors.red)),
              onPressed: () {
                // Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 100), () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) =>
                        false, // Remove all existing routes from the stack
                  );
                  sharedPrefs.setLogout();
                });
              },
              child: const Text(
                "Yes, Logout",
                style: TextStyle(
                  color: Colors.red,
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
    );
  }
}
