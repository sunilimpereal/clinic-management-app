// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:jatya_patient_mobile/utils/constants/color_konstants.dart';

class OTPForm extends StatefulWidget {
  double width;
  double height;
  Function(String) onChanged;
  OTPForm({
    Key? key,
    required this.width,
    required this.height,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  String otp = '';
  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 6,
      fieldWidth: widget.width,
      showFieldAsBox: true,
      borderColor: Colors.grey,
      focusedBorderColor: ColorKonstants.primarySwatch.shade400,
      onSubmit: (String code) {
        setState(() {
          otp = code;
        });
        widget.onChanged(otp);
      },
      onCodeChanged: (String code) {
        setState(() {
          otp = '';
        });
        widget.onChanged(otp);
      },
    );
  }
}
