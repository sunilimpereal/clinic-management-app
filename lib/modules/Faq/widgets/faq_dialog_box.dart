import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:clinic_app/modules/Auth/services/validators.dart';
import 'package:clinic_app/modules/Auth/widgets/custom_elevated_button.dart';
import 'package:clinic_app/modules/Auth/widgets/input_text_field.dart';
import 'package:clinic_app/modules/Faq/widgets/faq_success_dialog_box.dart';
import 'package:clinic_app/utils/SharePref.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQDialog extends StatefulWidget {
  const FAQDialog({super.key});

  @override
  State<FAQDialog> createState() => _FAQDialogState();
}

class _FAQDialogState extends State<FAQDialog> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<bool> sendEmail(String emailBody) async {
    String email = Uri.encodeComponent('support@jatyatech.com');
    String subject = Uri.encodeComponent('Help query');
    String finalBody =
        "Dear Support, \n\n JatyaId: ${sharedPrefs.jatyaId} \n\n Question: $emailBody";
    log(emailBody);
    String body = Uri.encodeComponent(finalBody);
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
      return true;
    } else {
      return false;
    }
  }

  String emailBody = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Help is a message away!',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputTextField(
              validator: (question) => Validators.faqValidator(question),
              textEditingController: _textEditingController,
              labelText: 'ASK YOUR QUESTION',
              hintText: 'Email',
              onChanged: (value) {
                setState(() {
                  emailBody = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: CustomElevatedButton(
            onPressed: () async {
              final snackbar = ScaffoldMessenger.of(context);
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).pop();
                bool res = await sendEmail(emailBody);
                if (res) {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (context) => BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10.0,
                        sigmaY: 10.0,
                      ),
                      child: const FaqSuccessDialogBox(),
                    ),
                  );
                } else {
                  snackbar.showSnackBar(
                    const SnackBar(
                      content: Text('Something Went Wrong!'),
                      duration: Duration(seconds: 5),
                    ),
                  );
                }
              }
            },
            horizontalWidth: MediaQuery.of(context).size.width * 0.25,
            verticalWidth: 12,
            text: 'Submit',
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
