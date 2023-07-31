import 'package:flutter/material.dart';
import 'package:jatya_patient_mobile/common_components/widgets/app_alert_dialog.dart';

class StartConsulationAlertDialog extends StatelessWidget {
  const StartConsulationAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAlertDialog(
        iconColor: Colors.orange.shade800,
        icon: const Icon(
          Icons.warning_rounded, color: Colors.white,
          // size: 55,
        ),
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          children: [
            const Text(
              'You are trying to connect with one of our doctor online. You will be charged for this consultation and the same will reflect in your Jatya Wallet. Do you wish to continue?',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 24),
            SizedBox(
                width: MediaQuery.of(context).size.width * .65,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('OK,Proceed'),
                )),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                'cancel',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ));
  }
}
