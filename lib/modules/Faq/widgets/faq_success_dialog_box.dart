import 'package:flutter/material.dart';
import 'package:jatya_patient_mobile/common_components/widgets/app_alert_dialog.dart';
import 'package:jatya_patient_mobile/modules/Auth/widgets/custom_elevated_button.dart';

class FaqSuccessDialogBox extends StatefulWidget {
  const FaqSuccessDialogBox({super.key});

  @override
  State<FaqSuccessDialogBox> createState() => _FaqSuccessDialogBoxState();
}

class _FaqSuccessDialogBoxState extends State<FaqSuccessDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppAlertDialog(
            iconColor: Colors.green,
            icon: Image.asset('assets/images/faq_success_dialog.png'),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                    'Thank you for reaching out to us. We will respond to your message as soon as possible and look forward to assisting you.'),
                CustomElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  horizontalWidth: MediaQuery.of(context).size.width * 0.25,
                  verticalWidth: 12,
                  text: 'OK',
                )
              ],
            )),
      ],
    );
  }
}
